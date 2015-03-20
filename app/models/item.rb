class Item < ActiveRecord::Base
	
	#Validations of any entered information to match the desired criteria
	
	#validations that these attributes are entered (NOT NULL) 
	validates_presence_of :item_name, :price, :description
	#validation of length of the item name (3 => 15 character)
	validates_length_of :item_name, minimum: 3, maximum: 15
	#validation of length of the description (MAX 200 chars)
	validates_length_of :description, maximum: 200
	#validation of length of the inspiration article (MAX 70 chars)
	validates_length_of :inspiration, maximum: 70

end
