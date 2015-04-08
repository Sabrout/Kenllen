class ItemController < ApplicationController
  
  def index
    #Creating an array of all items
  	@items = Item.all
  end

  def show
    #finding certain Item using id to use in show page
  	@item = Item.find(params[:id])
    @item_attachments = @item.item_attachments.all
  end

  def edit
    #finding certain item using id to edit
  	@item = Item.find(params[:id])
    @item_attachments = @item.item_attachments.all
  end

  def update
    #Find an existing item using form parameters
  	@item = Item.find(params[:id])
    #Update the item
  	if @item.update_attributes(item_params)
      
      if params[:item_attachments] 
        
        params[:item_attachments]['photo'].each do |a|
          @item_attachment = @item.item_attachments.create!(:photo => a, :item_id => @item.id)
        end
      end

      if @toDeleteImages
          @toDeleteImages.each do |i|
          i.destroy
        end
      end
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
    @item_attachment = @item.item_attachments.build
  end

  def create
    #Instantiate a new Item using form parameters
  	@item = Item.new(item_params)
    @item.category = params[:category]
    #Save the item
  	if @item.save
      if params[:item_attachments]
        params[:item_attachments]['photo'].each do |a|
          @item_attachment = @item.item_attachments.create!(:photo => a, :item_id => @item.id)
        end
      end
      #if save succeeds redirect to the index action
  		redirect_to(:action => 'index')
  	else
      #if save fails rerender the new form for the user to correct the inputs
  		render('new')
  	end
  end

  def delete
   @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id]).destroy
    @item.item_attachments.all.each do |a|
      a.destroy
    end
    redirect_to(:action => 'index')
  end

  def destroyImage
    @item = Item.find(params[:id])
    @item.item_attachments.all.find(params[:attachment_id]).destroy
    redirect_to(:action => 'show', :id => @item.id)
  end

  def filterCategories
    categ = params[:category]
    @itemsList = Item.find_by_category(categ)
  end

private
	def item_params
    #same as using "params[:item]", Except that it :
    # - raises an error if :item is not present
    # - allows listed attributes to be mass assigned
		params.require(:item).permit(:item_name, :price, :description, :inspiration, item_attachments_attributes: [:id, :item_id, :photo])
	end
end