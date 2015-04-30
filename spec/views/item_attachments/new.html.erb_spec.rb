require 'rails_helper'

RSpec.describe "item_attachments/new", type: :view do
  before(:each) do
    assign(:item_attachment, ItemAttachment.new(
      :item_id => 1,
      :photo => "MyString"
    ))
  end

  it "renders new item_attachment form" do
    render

    assert_select "form[action=?][method=?]", item_attachments_path, "post" do

      assert_select "input#item_attachment_item_id[name=?]", "item_attachment[item_id]"

      assert_select "input#item_attachment_photo[name=?]", "item_attachment[photo]"
    end
  end
end
