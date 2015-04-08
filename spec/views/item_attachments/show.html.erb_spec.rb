require 'rails_helper'

RSpec.describe "item_attachments/show", type: :view do
  before(:each) do
    @item_attachment = assign(:item_attachment, ItemAttachment.create!(
      :item_id => 1,
      :photo => "Photo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Photo/)
  end
end
