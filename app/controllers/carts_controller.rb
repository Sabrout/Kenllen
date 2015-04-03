class CartsController < ApplicationController

	def index

	end

	def destroy
		@cart.destroy
		session[:cart_id] = nil # check if user is sign_in to delete the cart id from the database or not
		flash[:notice] = "Your Cart Is Clear."
		redirect_to root_path
	end
end
