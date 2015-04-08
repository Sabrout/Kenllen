require 'rails_helper'

RSpec.describe "ItemAttachments", type: :request do
  describe "GET /item_attachments" do
    it "works! (now write some real specs)" do
      get item_attachments_path
      expect(response).to have_http_status(200)
    end
  end
end
