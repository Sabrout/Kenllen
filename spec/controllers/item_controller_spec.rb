require 'rails_helper'

RSpec.describe ItemController, type: :controller do
	describe "report" do # test if a user gets banned with only two reports
        it "reports an item" do
        	owner = FactoryGirl.create(:user , fname: "owner")
        	shop = FactoryGirl.create(:shop , user: owner)
    		item = FactoryGirl.create(:item , shop: shop)
    		user = FactoryGirl.create(:user)
            sign_in user
            @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
            post :report, {:id => item.id} 
            expect(owner.reports).to eq 0# expect count of report to stay the same (zero) for a user
            expect(ItemReport.count(item.id)).to eq 1# expect count of item_report to increate
        end

        it "reports an item till deletion" do # report same item 3 times till deletion
    		owner = FactoryGirl.create(:user , fname: "owner")
        	shop = FactoryGirl.create(:shop , user: owner)
    		item = FactoryGirl.create(:item , shop: shop)
    		i = 1
			while i < 50 						# report 49 times
			   user = FactoryGirl.create(:user)
			   report = FactoryGirl.create(:item_report , item_id: item.id , user_id: user.id)
			   i +=1
			end
			user = FactoryGirl.create(:user)
			sign_in user
			@request.env['HTTP_REFERER'] = 'http://localhost:3000/'
			post :report, {:id => item.id} 
			expect(User.find(owner.id).reports).to eq 1 and # expect reports count to increment
			expect(ItemReport.exists?(item.id)).to eq false# expect item to be deleted
        end

        it "reports 3 items till ban of owner" do
    		owner = FactoryGirl.create(:user , fname: "owner")
        	shop = FactoryGirl.create(:shop , user: owner)
    		item1 = FactoryGirl.create(:item , shop: shop)
    		item2 = FactoryGirl.create(:item , shop: shop)
    		item3 = FactoryGirl.create(:item , shop: shop)
    		i = 1
    		j = 1
    		k = 1
			while i < 50 						# report 49 times
			   user = FactoryGirl.create(:user)
			   report = FactoryGirl.create(:item_report , item_id: item1.id , user_id: user.id)
			   i +=1
			end
			while j < 50 						# report 49 times
			   user = FactoryGirl.create(:user)
			   report = FactoryGirl.create(:item_report , item_id: item2.id , user_id: user.id)
			   j +=1
			end
			while k < 50 						# report 49 times
			   user = FactoryGirl.create(:user)
			   report = FactoryGirl.create(:item_report , item_id: item3.id , user_id: user.id)
			   k +=1
			end
			user = FactoryGirl.create(:user)
			sign_in user
			@request.env['HTTP_REFERER'] = 'http://localhost:3000/'
			post :report, {:id => item1.id} 
			post :report, {:id => item2.id} 
			post :report, {:id => item3.id} 
			expect(User.find(owner.id).reports).to eq 0 and 	# reset reports Count
			expect(User.find(owner.id).banned).to eq true		# ban the user
        end
    end
end
