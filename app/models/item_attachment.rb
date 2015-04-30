class ItemAttachment < ActiveRecord::Base
	
	mount_uploader :photo, PhotoUploader
	belongs_to :item
end
