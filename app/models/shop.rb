class Shop < ActiveRecord::Base
	
	

	self.table_name = 'shops'

	# Associations
	belongs_to :user
	has_many :items
	has_and_belongs_to_many :followers, class_name: "User", join_table: "shops_users"

	# Scopes (Methods used in the controller)
	scope :sorted, lambda { order("shops.shop_name ASC")}
	scope :search, lambda {|query|
		where(["shop_name LIKE ?", "%#{query}%"])}
	mount_uploader :cover, ImageUploader

end
