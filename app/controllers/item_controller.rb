class ItemController < ApplicationController
  
  def index
    #Creating an array of all items
  	@items = Item.all
  end

  def show
    #finding certain Item using id to use in show page
  	@item = Item.find(params[:id])
  end

  def edit
    #finding certain item using id to edit
  	@item = Item.find(params[:id])
  end

  def update
    #Find an existing item using form parameters
  	@item = Item.find(params[:id])
    #Update the item
  	if @item.update_attributes(item_params)
  		#if update succeeds, redirect to the show action
      redirect_to(:action => 'show', :id => @item.id)
  	else
      #if update fails, rerender the edit page for the use to correct the form
  		render('edit')
  	end
  end

  def new
    #Instantiate a new Item with default values
  	@item = Item.new
  end

  def create
    #Instantiate a new Item using form parameters
  	@item = Item.new(item_params)
    #Save the item
  	if @item.save
      #if save succeeds redirect to the index action
  		redirect_to(:action => 'index')
  	else
      #if save fails rerender the new form for the user to correct the inputs
  		render('new')
  	end
  end

private
	def item_params
    #same as using "params[:item]", Except that it :
    # - raises an error if :item is not present
    # - allows listed attributes to be mass assigned
		params.require(:item).permit(:item_name, :price, :description, :inspiration)
	end
end