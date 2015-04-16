require 'rails_helper'

RSpec.describe "item_attachments/edit", type: :view do
  before(:each) do
    @item_attachment = assign(:item_attachment, ItemAttachment.create!(
      :item_id => 1,
      :photo => "MyString"
    ))
  end

  it "renders the edit item_attachment form" do
    render

    assert_select "form[action=?][method=?]", item_attachment_path(@item_attachment), "post" do

      assert_select "input#item_attachment_item_id[name=?]", "item_attachment[item_id]"

      assert_select "input#item_attachment_photo[name=?]", "item_attachment[photo]"
    end
  end
end
