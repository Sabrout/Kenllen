class ShopsController < ApplicationController
  def index
  	@shops = Shop.sorted
  end

  def show
  	@shop = Shop.find(params[:shop_id])
  end

  def new
    @shop = Shop.new(:shop_name => 'default')
  end

  def create
    # Instantiate a new object - shop_params is a private methode
    @shop = Shop.new(shop_params)
    # Save
    if @shop.save
      # If succeeds, redirect
      redirect_to(:action => 'index')
    else
      # If fails, redisplay
      flash[:notice] = "Shop created successfully."
      render('new')
    end
  end

  def edit
    @shop = Shop.find(params[:shop_id])
  end

  def update
    # Find an existing object
    @shop = Shop.find(params[:shop_id])
    # Update the object
    if @shop.update_attributes(shop_params)
      # If succeeds, redirect
      flash[:notice] = "Shop updated successfully."
      redirect_to(:action => 'show', :shop_id => @shop.shop_id)
    else
      # If fails, redisplay
      render('edit')
    end
  end

  def delete
    @shop = Shop.find(params[:shop_id])
  end

  def destroy
    # Find an existing object and destroy it
    shop = Shop.find(params[:shop_id]).destroy
    flash[:notice] = "Shop '#{shop.shop_name}' deleted successfully."
    redirect_to(:action => 'index')
  end

  # Mass assignement parameter
  # It raises an error if :subject is not present
  private
  def shop_params
    params.require(:shop).permit(:shop_name, :shop_desc)
  end
end
