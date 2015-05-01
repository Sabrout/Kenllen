require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  describe "reported? For the First Time" do  # test reported method (item not reported by user)
    it "returns false (user has never reported this item)" do
    	item = FactoryGirl.create(:item)
        user = FactoryGirl.create(:user)
        expect(controller.reported?(item.id,user.id)).to eq false
    end
  end

  describe "reported? For the Second Time" do # test reported method (item already reported by user)
    it "returns true (user already reported that item)" do
        item = FactoryGirl.create(:item)
        user = FactoryGirl.create(:user)
        report = FactoryGirl.create(:item_report , user_id: user.id , item_id: item.id)
        expect(controller.reported?(item.id,user.id)).to eq true
    end
  end
end