class CreateItems < ActiveRecord::Migration
  def change
  	#Migration used to create the table "Items" in the database to store the required info about the items.
    create_table :items do |t|
      t.integer "shop_id"
      t.string "item_name", :limit => 15, :null => false
      t.string "description", :limit => 200, :default => ""
      t.string "inspiration", :limit => 70, :default => ""
      t.decimal "price", :null => false
      t.integer "quantity" , :default => 1
      
      t.timestamps null: false
    end
    add_index("items", "shop_id")
  end
end
