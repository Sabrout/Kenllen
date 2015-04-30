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

  def report 
    # report the item
    ItemReports.create(user_id:current_user.id,item_id:params[:id])
    flash[:notice] = "Item Reported Successfully"
    if (ItemReports.count(params[:id]) >= 3) # count number of reports for a given item
      #delete Item
      flash[:notice] = "Item Is now DELETED , thank you for the feedback"
      item = Item.find(params[:id])
      #add to user reports 1 
      user = User.find(item.shop.user.id)
      item.destroy
      reports = user.reports + 1
      user.update_without_password(reports: reports)
      if (user.reports >= 3) 
        user.update_without_password(banned: true) # ban the user
        user.update_without_password(reports: 0)  # reset the reports count
        user.delay(run_at: 14.days.from_now).update_without_password(banned: false)# initialize the count for unbanning
      end
      #count user reports , If >= 3 then ban user for 2 weeks and reset it
    end
    redirect_to :back
  end

  def update
    #Find an existing item using form parameters
  	@item = Item.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    #Update the item
    if current_user.shops.include?(@shop)
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
  end

  def new
    #Instantiate a new Item with default values

  	@item = Item.new
    @item_attachment = @item.item_attachments.build
    @shop = Shop.find(params[:shop_id])
  end

  def create
    #Instantiate a new Item using form parameters
  	@item = Item.new(item_params)
    @item.category = params[:category]
    @shop = Shop.find(params[:shop_id])
    #Save the item
    
    if @item.save
      if params[:item_attachments]
        params[:item_attachments]['photo'].each do |a|
          @item_attachment = @item.item_attachments.create!(:photo => a, :item_id => @item.id)
        end
      end
      #if save succeeds redirect to the index action
      @shop.items << @item

      redirect_to({:controller => 'shops', :action => 'show', :id => @shop.id})
    else
      #if save fails rerender the new form for the user to correct the inputs
      render('new')
    end
    end
  end

  def delete
   item = Item.find(params[:id])
   @shop = Shop.find(params[:shop_id])
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    if current_user.shops.include?(@shop)
    @item = Item.find(params[:id]).destroy
    redirect_to({:controller => 'shops', :action => 'show', :id => @shop.id})
    end
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

  def user_params
     params.require(:user).permit(:reports, :banned)
  end