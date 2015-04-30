require 'rails_helper'

RSpec.describe "item_attachments/index", type: :view do
  before(:each) do
    assign(:item_attachments, [
      ItemAttachment.create!(
        :item_id => 1,
        :photo => "Photo"
      ),
      ItemAttachment.create!(
        :item_id => 1,
        :photo => "Photo"
      )
    ])
  end

  it "renders a list of item_attachments" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Photo".to_s, :count => 2
  end
end
