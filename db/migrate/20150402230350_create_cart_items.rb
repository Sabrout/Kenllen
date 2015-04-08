class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :quantity , default: 1
      t.integer :cart_id
      t.integer :item_id
      t.timestamps null: false
    end
    add_index("cart_items", "item_id")
  end
end
