class ShopsController < ApplicationController
  def index
    # sorted is a scope (small procedure) in the model
  	@shops = Shop.sorted
  end

  def search
    # Searches for a shop
    if !params[:query].empty?
      @shops = Shop.search(params[:query])
      @items = Item.search(params[:query])
    end
  end

  def follow
    # Adds the shop to the current user's followed shops
    @current_user = current_user
    @shop = Shop.find(params[:id])
    if !current_user.shops.include?(@shop)
    @current_user.followed_shops << @shop
    end
    flash[:notice] = "You are now following '#{@shop.shop_name}.'"
    redirect_to(:action => 'show', :id => @shop.id)
  end

  def unfollow
    # Removes the shop from the current user's followed shops
    @current_user = current_user
    @shop = Shop.find(params[:id])
    @current_user.followed_shops.delete(@shop)
    flash[:notice] = "You are no longer following '#{@shop.shop_name}.'"
    redirect_to(:action => 'show', :id => @shop.id)
  end

  def show
  	@shop = Shop.find(params[:id])
    @item = @shop.items
# Client.where("orders_count = ? AND locked = ?", params[:orders], false)
@categoryOne = @item.where("category = ")
  end

  def new
    @shop = Shop.new(:shop_name => 'default')
  end

  def create
    # Instantiate a new object - shop_params is a private methode
    @shop = Shop.new(shop_params)
    @user = current_user
    @shop.user = @user
    # Save
    if @shop.save
      # If succeeds, redirect
      redirect_to(:controller => 'profile', :action => 'myshops')
      flash[:notice] = "Shop created successfully."
    else
      # If fails, redisplay
      render('new')
    end
  end

  def edit
    # Check if current user already owns the shop in order to edit
    @shop = Shop.find(params[:id])
  end

  def update
    # Find an existing object
    @shop = Shop.find(params[:id])
    # Update the object
    if @shop.update_attributes(shop_params)
      # If succeeds, redirect
      flash[:notice] = "Shop updated successfully."
      redirect_to(:action => 'show', :id => @shop.id)
    else
      # If fails, redisplay
      render('edit')
    end
  end

  def delete
    # Check if user already owns the shop inorder to delete it
    @shop = Shop.find(params[:id])
    if current_user.shops.include?(@shop)
    else
    render 'index'
    end
  end

  def destroy
    # Find an existing object and destroy it
    shop = Shop.find(params[:id])
    if current_user.shops.include?(shop)
    	shop.destroy
    	item = shop.items
    	item.each do |item| 
    	Item.destroy(item)
    	end
    	flash[:notice] = "Shop '#{shop.shop_name}' deleted successfully."
    	redirect_to(:action => 'index')
    else 
    	render 'index'
    end
  end

  # Mass assignement parameter
  # It raises an error if :subject is not present
  private
  def shop_params
    params.require(:shop).permit(:shop_name, :shop_desc, :cover)
  end
end
