class Item < ActiveRecord::Base
<<<<<<< HEAD
=======

	
	
>>>>>>> origin/master
	self.table_name = 'items'
	belongs_to :shop
	has_one :cart_item
end
