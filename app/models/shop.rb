class Shop < ActiveRecord::Base

	self.table_name = 'shops'
	belongs_to :user
	has_many :items
	scope :sorted, lambda { order("shops.shop_name ASC")}
	scope :search, lambda {|query|
		where(["shop_name LIKE ?", "%#{query}%"])}
	mount_uploader :cover, ImageUploader

end
