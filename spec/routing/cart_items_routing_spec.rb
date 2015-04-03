require "rails_helper"

RSpec.describe CartItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cart_items").to route_to("cart_items#index")
    end

    it "routes to #new" do
      expect(:get => "/cart_items/new").to route_to("cart_items#new")
    end

    it "routes to #show" do
      expect(:get => "/cart_items/1").to route_to("cart_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cart_items/1/edit").to route_to("cart_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cart_items").to route_to("cart_items#create")
    end

    it "routes to #update" do
      expect(:put => "/cart_items/1").to route_to("cart_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cart_items/1").to route_to("cart_items#destroy", :id => "1")
    end

  end
end
