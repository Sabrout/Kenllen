class ShopsController < ApplicationController
  def index
    # sorted is a lambda (small procedure) in the model
  	@shops = Shop.sorted
  end

<<<<<<< HEAD
  def follow
  end

  def show
  	@shop = Shop.find(params[:id])
=======
  def show
  	@shop = Shop.find(params[:shop_id])
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
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
<<<<<<< HEAD
    @shop = Shop.find(params[:id])
=======
    @shop = Shop.find(params[:shop_id])
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
  end

  def update
    # Find an existing object
<<<<<<< HEAD
    @shop = Shop.find(params[:id])
=======
    @shop = Shop.find(params[:shop_id])
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
    # Update the object
    if @shop.update_attributes(shop_params)
      # If succeeds, redirect
      flash[:notice] = "Shop updated successfully."
<<<<<<< HEAD
      redirect_to(:action => 'show', :id => @shop.id)
=======
      redirect_to(:action => 'show', :shop_id => @shop.shop_id)
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
    else
      # If fails, redisplay
      render('edit')
    end
  end

  def delete
<<<<<<< HEAD
    @shop = Shop.find(params[:id])
=======
    @shop = Shop.find(params[:shop_id])
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
  end

  def destroy
    # Find an existing object and destroy it
<<<<<<< HEAD
    shop = Shop.find(params[:id]).destroy
=======
    shop = Shop.find(params[:shop_id]).destroy
>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
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
