require "rails_helper"

RSpec.describe ItemAttachmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/item_attachments").to route_to("item_attachments#index")
    end

    it "routes to #new" do
      expect(:get => "/item_attachments/new").to route_to("item_attachments#new")
    end

    it "routes to #show" do
      expect(:get => "/item_attachments/1").to route_to("item_attachments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/item_attachments/1/edit").to route_to("item_attachments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/item_attachments").to route_to("item_attachments#create")
    end

    it "routes to #update" do
      expect(:put => "/item_attachments/1").to route_to("item_attachments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/item_attachments/1").to route_to("item_attachments#destroy", :id => "1")
    end

  end
end
