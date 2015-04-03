class CartItemsController < ApplicationController
	
	# create a new cart item
	def create
			item = Item.find(params[:item_id])
		if add_item?(item)
			flash[:notice] = 'added item to your cart'
		else
			flash[:notice] = 'item Already In the Cart'
		end
		redirect_to carts_path
	end

	#remove a cart item
	def destroy
		CartItem.destroy(params[:cart_item_id])
		redirect_to :back
	end	

	#increase the quantity of a cart item
	def increment
		cart_item = @cart.cart_items.find(params[:cart_item_id])
			if increment_quantity?(cart_item)
				cart_item.quantity+=1
				cart_item.update_attributes(quantity: cart_item.quantity)
			end
		redirect_to :back
	end

	#decrease the quantity of a cart item
	def decrement
		cart_item = CartItem.find(params[:cart_item_id])
			if decrement_quantity?(cart_item)
				cart_item.quantity-=1
				cart_item.update_attributes(quantity: cart_item.quantity)
			end
		redirect_to :back
	end

private
	#checks if an item exist in the cart already
	def add_item?(item)
			cart_item = @cart.cart_items.find_by(item_id: item)
		if(cart_item)
			return false
		end
			cart_item = @cart.cart_items.create(item: item)
			return true
	end

	#increate the quantity and 
	def increment_quantity?(cart_item)
			if(cart_item.quantity == cart_item.item.quantity)
				return false
			else
				return true
			end
	end

	def decrement_quantity?(cart_item)
			if(cart_item.quantity == 1)
				return false
			else
				return true
			end
	end

end
