class ItemController < ApplicationController
  
  def index
  	@items = Item.all
  end

  def show
  	@item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      redirect_to(:action => 'show', :id => @item.id)
    else
      render('edit')
    end
  end

  def new
  	@item = Item.new
  end

  def create
  	@item = Item.new(item_params)
  	if @item.save
  		redirect_to(:action => 'index')
  	else
  		render('new')
  	end
  end

private
	def item_params
		params.require(:item).permit(:item_name, :price, :description, :inspiration)
	end
end