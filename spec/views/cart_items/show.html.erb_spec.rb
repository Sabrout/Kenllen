require 'rails_helper'

RSpec.describe "cart_items/show", type: :view do
  before(:each) do
    @cart_item = assign(:cart_item, CartItem.create!(
      :quantity => 1,
      :cart_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
