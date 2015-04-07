class CartsController < ApplicationController
	#used for the view index
	def index
		if (current_user)  #checks if a user is logged in
			@cart = current_cart
			render 'carts/index'
		else        # else create a temporary cart
			@cart =	temporary_cart
			@cart.each do |cartItem|
				cartItem[1][5] = cartItem[1][1].to_i * cartItem[1][3].to_i
			end
			@totalPrice = 0
			@cart.each do |cartItem|
				@totalPrice += cartItem[1][5].to_i
			end
			render 'carts/temporary_cart'
		end
	end

	#update cart_item Quantities in temporary cart
	def update_quantity
		item_id = params[:cart_item_id]
		if (cart_params[:quantity].to_i > temporary_cart[item_id][4])
			flash[:error] = 'Cannot Order with quantity higher than the available in stock.'
		else
			flash[:notice] = 'Cart Updated'
			temporary_cart[item_id][1] = cart_params[:quantity]
		end
		redirect_to :back
	end

	#delete cart_item from Cart (temporary cart)
	def remove_item
		item_id = params[:cart_item_id]
		temporary_cart.delete(item_id)
		redirect_to :back
	end

	#delete the cart from the database
	def destroy
		if(current_user)	 # check if user is sign_in to delete the cart id from the database or not
			cart = current_cart
			Cart.destroy(cart)	 # destroy in database
		else
			session[:temporary_cart] = nil
		end
		flash[:notice] = "Your Cart Is Clear."
		redirect_to root_path
	end
	#allows the quantity field
	private 
	def cart_params
		params.require(:cart).permit(:quantity)
	end
end
