require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    describe "banned? (with two reports)" do # test if a user gets banned with only two reports
        it "keeps the user logged in" do
        	user = FactoryGirl.create(:user)
            sign_in user
            expect(controller.banned?).to eq nil	# didn't Enter the If Condition so expecting nil
        end
 
        it "redirects to root_path , logs out the current user" do  # test if a logged user gets banned with three reports
            user = FactoryGirl.create(:user)
          	sign_in user
          	user.update_without_password(banned: true)
        	get :banned?
            expect(response).to redirect_to(root_path) and        # redirected to home
            expect(controller.send(:current_user)).to eq(nil)     # user is logged out now 
        end
    end

    describe "reported? For the First Time" do  # test reported method (item not reported by user)
        it "returns false (user has never reported this item)" do
        	item = FactoryGirl.create(:item)
            user = FactoryGirl.create(:user)
            expect(controller.reported?(item.id,user.id)).to eq false
        end

        it "returns true (user already reported that item)" do # test reported method (item already reported by user)
            item = FactoryGirl.create(:item)
            user = FactoryGirl.create(:user)
            report = FactoryGirl.create(:item_report , user_id: user.id , item_id: item.id)
            expect(controller.reported?(item.id,user.id)).to eq true
        end
    end
end