class CartController < ApplicationController

	def index
		@cart = current_cart
	end
end
