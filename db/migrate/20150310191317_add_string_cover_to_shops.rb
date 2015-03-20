class AddStringCoverToShops < ActiveRecord::Migration
  def self.up
  	change_table :shops do |t|
        t.string :cover
      end
  end
end
