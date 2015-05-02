class CreateItemsUsersJoin < ActiveRecord::Migration
  def up
  	# This table has lists of users and the shops they follow
    create_table :items_users, :id => false do |t|
    	t.integer "user_id"
    	t.integer "item_id"
    end
    add_index :items_users, ["item_id", "user_id"]
  end

  def down
  	drop_table :items_users
  end
end
