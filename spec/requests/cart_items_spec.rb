require 'rails_helper'

RSpec.describe "CartItems", type: :request do
  describe "GET /cart_items" do
    it "works! (now write some real specs)" do
      get cart_items_path
      expect(response).to have_http_status(200)
    end
  end
end
