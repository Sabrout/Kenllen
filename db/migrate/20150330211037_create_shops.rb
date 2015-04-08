class CreateShops < ActiveRecord::Migration
  def up
    create_table :shops do |t|

      t.integer "user_id"
    	t.string "shop_name", null: false, limit: 25
    	t.text "shop_desc"
    	t.string "cover"
    	t.string "icon"

      t.timestamps null: false
    end
    add_index("shops", "user_id")
  end

  def down
  	drop_table :shops
  end

end
