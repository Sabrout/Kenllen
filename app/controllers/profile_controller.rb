class ProfileController < ApplicationController
	 def myshops
    # create two tables, one for the user's shops and the other is for his followed shops
    @current_user = current_user
    @shops = current_user.shops
    @followed_shops = current_user.followed_shops
  end
end