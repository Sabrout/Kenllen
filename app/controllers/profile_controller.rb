class ProfileController < ApplicationController
	 def myshops
    
    @current_user = current_user
    @shops = current_user.shops
    @followed_shops = current_user.followed_shops
  end
end