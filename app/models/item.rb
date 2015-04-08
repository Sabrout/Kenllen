class Item < ActiveRecord::Base

	self.table_name = 'items'
	belongs_to :shop
end
