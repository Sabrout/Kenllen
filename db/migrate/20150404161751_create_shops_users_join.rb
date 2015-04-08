class CreateShopsUsersJoin < ActiveRecord::Migration
  def up
  	# This table has lists of users and the shops they follow
    create_table :shops_users, :id => false do |t|
    	t.integer "user_id"
    	t.integer "shop_id"
    end
    add_index :shops_users, ["shop_id", "user_id"]
  end

  def down
  	drop_table :shops_users
  end
end
