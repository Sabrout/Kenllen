class Item < ActiveRecord::Base

	validates_presence_of :item_name, :price, :description
	validates_length_of :item_name, minimum: 3, maximum: 15
	validates_length_of :description, maximum: 200
	validates_length_of :inspiration, maximum: 70

end
