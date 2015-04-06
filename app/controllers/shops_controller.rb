class ShopsController < ApplicationController
  def index
    # sorted is a scope (small procedure) in the model
  	@shops = Shop.sorted
  end

  def follow
    # Adds the shop to the current user's followed shops
    @current_user = current_user
    @shop = Shop.find(params[:id])
    @current_user.followed_shops << @shop
    render 'show'
  end

  def unfollow
    # Removes the shop from the current user's followed shops
    @current_user = current_user
    @shop = Shop.find(params[:id])
    @current_user.followed_shops.delete(@shop)
    render 'show'
  end

  def show
  	@shop = Shop.find(params[:id])
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
      redirect_to(:action => 'index')
      flash[:notice] = "Shop created successfully."
    else
      # If fails, redisplay
      render('new')
    end
  end

  def edit
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
    @shop = Shop.find(params[:id])
  end

  def destroy
    # Find an existing object and destroy it
    shop = Shop.find(params[:id]).destroy
    flash[:notice] = "Shop '#{shop.shop_name}' deleted successfully."
    redirect_to(:action => 'index')
  end

  # Mass assignement parameter
  # It raises an error if :subject is not present
  private
  def shop_params
    params.require(:shop).permit(:shop_name, :shop_desc, :cover)
  end
end
