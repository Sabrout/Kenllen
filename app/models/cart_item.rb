class CartItem < ActiveRecord::Base
	belongs_to :cart
	belongs_to :item
	default_scope {order('created_at ASC')}
	def total_price
		item.price * quantity
	end
end