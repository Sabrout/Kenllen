class Shop < ActiveRecord::Base

	self.table_name = 'shops'
<<<<<<< HEAD
	belongs_to :user
	has_many :items
	scope :sorted, lambda { order("shops.shop_name ASC")}
	scope :search, lambda {|query|
		where(["shop_name LIKE ?", "%#{query}%"])}
	mount_uploader :cover, ImageUploader
=======

	scope :sorted, lambda { order("shops.shop_name ASC")}
	scope :search, lambda {|query|
		where(["shop_name LIKE ?", "%#{query}%"])}

		mount_uploader :cover, ImageUploader
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29

end
