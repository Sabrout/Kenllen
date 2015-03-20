class Shop < ActiveRecord::Base

	self.table_name = 'shops'

	scope :sorted, lambda { order("shops.shop_name ASC")}
	scope :search, lambda {|query|
		where(["shop_name LIKE ?", "%#{query}%"])}

		mount_uploader :cover, ImageUploader

end
