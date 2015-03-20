class CreateItems < ActiveRecord::Migration
  def change
  	#Migration used to create the table "Items" in the database to store the required info about the items.
    create_table :items do |t|
      t.string "item_name", :limit => 15, :null => false
      t.string "description", :limit => 200, :default => ""
      t.string "inspiration", :limit => 70, :default => ""
      t.decimal "price", :null => false
      
      t.timestamps null: false
    end
  end
end
