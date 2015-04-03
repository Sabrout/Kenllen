class CartItemsController < ApplicationController
	

	def create
			item = Item.find(params[:item_id])
			@cart_item = @cart.cart_items.new(item: item)
		if @cart_item.save
			redirect_to carts_path
		end
	end

	def destroy

	end


end
