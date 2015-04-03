require 'rails_helper'

RSpec.describe "carts/edit", type: :view do
  before(:each) do
    @cart = assign(:cart, Cart.create!())
  end

  it "renders the edit cart form" do
    render

    assert_select "form[action=?][method=?]", cart_path(@cart), "post" do
    end
  end
end
