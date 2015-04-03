class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.integer :cart_id
      t.integer :item_id
      t.timestamps null: false
    end
  end
end
