class HomeController < ApplicationController
	
	def index
		@current_user = current_user
		@items = Item.all 
	end
end
