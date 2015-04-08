class CartItemsController < ApplicationController
	
	# create a new cart item
	def create
		if (current_user) # check if a user is logged in
			cart = current_cart
			item = Item.find(params[:item_id])
			if add_item?(item,cart)
				flash[:notice] = 'added item to your cart' 
			else
				flash[:notice] = 'item Already In the Cart'
			end
		else 	# else if a user isn't logged in
			item = Item.find(params[:item_id])
			temporary_cart
			if (!session[:temporary_cart][params[:item_id]])
				cart_item = Array.new 
				cart_item[0] = item.item_name
				cart_item[1] = 1
				cart_item[2] = item.description
				cart_item[3] = item.price
				cart_item[4] = item.quantity
				session[:temporary_cart][item.id] = cart_item 
				flash[:notice] = 'added item to your cart'
			else
				flash[:notice] = 'item Already In the Cart'
			end
		end
		redirect_to carts_path
	end

	#remove a cart item from a cart (in database)
	def destroy
		CartItem.destroy(params[:cart_item_id])
		cart = current_cart
			if(lastElement?(cart))
			current_cart = nil
			Cart.destroy(cart)
			end
		redirect_to :back
	end	

	#update the quantity of a cart item (in database)
	def update_quantity
		cart = current_cart
		cart_item = cart.cart_items.find(params[:cart_item_id])
			if(update_quantity?(cart_item_params , cart_item))
				cart_item.update_attributes(cart_item_params)
				flash[:notice] = 'Cart Updated'
			else
				flash[:error] = 'Cannot Order with quantity higher than the available in stock.'
			end
		redirect_to :back
	end

private
	#checks if an item already exists in the cart 
	def add_item?(item,cart)
			cart_item = cart.cart_items.find_by(item_id: item)
		if(cart_item)
			return false
		end
			cart_item = cart.cart_items.create(item: item)
			return true
	end

	#increate the quantity and 
	def update_quantity?(cart_item_params , cart_item)
			if(cart_item_params[:quantity].to_i > cart_item.item.quantity)
				return false
			else
				return true
			end
	end
	#checks if the cart has no more elements
	def lastElement?(cart)
			if(cart.cart_items.count == 0) 
				return true
			else
				return false
			end
	end	
	#allows quantity to be passed in params and retrieved from it
  	def cart_item_params
   	 params.require(:cart_item).permit(:quantity)
  	end
end
