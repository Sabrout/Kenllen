class CartItemsController < ApplicationController
	

	def create
		@cart = current_cart
		item = Item.find(params[:item_id])
		@cart_item = @cart.cart_items.new(item: item)
		if @cart_item.save
			redirect_to cart_index_path
		end
	end

	def destroy

	end


end
