class Item < ActiveRecord::Base
	belongs_to :shop
	has_many :item_attachments
	has_one :cart_item
    accepts_nested_attributes_for :item_attachments
	#Validations of any entered information to match the desired criteria
	
	#validations that these attributes are entered (NOT NULL) 
	validates_presence_of :item_name, :price, :description, message: "Required field."
	#validation of length of the item name (3 => 15 character)
	validates_length_of :item_name, minimum: 3, maximum: 15, message: "Name has to be between 3 and 15 characters!"
	#validation of length of the description (MAX 200 chars)
	validates_length_of :description, maximum: 200, message: "Description can't be more than 200 characters long!"
	#validation of length of the inspiration article (MAX 70 chars)
	validates_length_of :inspiration, maximum: 70, message: "Inspiration can't be more than 70 characters long!"
	validates :price, :numericality => {:only_integer => true}

	scope :search, lambda {|query|
		where(["shop_name LIKE ?", "%#{query}%"])}
end
