class RemoveTimestampsFromCartItems < ActiveRecord::Migration
  def change
    remove_column :cart_items, :updated_at, :string
  end
end
