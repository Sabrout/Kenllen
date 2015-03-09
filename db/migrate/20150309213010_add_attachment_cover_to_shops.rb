class AddAttachmentCoverToShops < ActiveRecord::Migration
  def self.up
    change_table :shops do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :shops, :cover
  end
end
