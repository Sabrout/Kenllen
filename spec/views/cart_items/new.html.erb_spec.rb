require 'rails_helper'

RSpec.describe "cart_items/new", type: :view do
  before(:each) do
    assign(:cart_item, CartItem.new(
      :quantity => 1,
      :cart_id => 1
    ))
  end

  it "renders new cart_item form" do
    render

    assert_select "form[action=?][method=?]", cart_items_path, "post" do

      assert_select "input#cart_item_quantity[name=?]", "cart_item[quantity]"

      assert_select "input#cart_item_cart_id[name=?]", "cart_item[cart_id]"
    end
  end
end
