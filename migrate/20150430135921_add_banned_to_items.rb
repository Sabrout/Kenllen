class AddBannedToItems < ActiveRecord::Migration
  def change
    add_column :items, :banned, :boolean
  end
end
