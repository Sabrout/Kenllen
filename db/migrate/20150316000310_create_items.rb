class CreateItems < ActiveRecord::Migration
  def change
  	#Migration used to create the table "Items" in the database to store the required info about the items.
    create_table :items do |t|
<<<<<<< HEAD
      t.integer "shop_id"
=======
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
      t.string "item_name", :limit => 15, :null => false
      t.string "description", :limit => 200, :default => ""
      t.string "inspiration", :limit => 70, :default => ""
      t.decimal "price", :null => false
      
      t.timestamps null: false
    end
<<<<<<< HEAD
    add_index("items", "shop_id")
=======
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
  end
end
