require 'rails_helper'

RSpec.describe "carts/index", type: :view do
  before(:each) do
    assign(:carts, [
      Cart.create!(),
      Cart.create!()
    ])
  end

  it "renders a list of carts" do
    render
  end
end
