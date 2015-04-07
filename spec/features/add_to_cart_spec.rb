require 'rails_helper'

RSpec.feature "AddToCart", type: :feature do
	
	scenario 'Add To Cart (Guest)' do		# checks if a guest can add item
		create_item(1,50)
		add_item_to_cart(1)
		expect(page.body).to  have_content("added item")
	end

	scenario 'Add To Cart (LoggedInUser)' do		# checks if a user can add item
		#missing login
		create_item(1,50)
		add_item_to_cart(2)
		expect(page.body).to  have_content("added item")
	end

	scenario 'Add To Cart Already Added Item (Guest)' do		# checks if a guest can add item that's already in cart
		create_item(1,50)
		add_item_to_cart(3)
		visit Item
		add_item_to_cart(3)
		expect(page.body).to  have_content("Already In the Cart")
	end

	scenario 'Add To Cart Already Added Item (LoggedInUser)' do		# checks if a user can add item that's already in cart
		#missing login
		create_item(1,50)
		add_item_to_cart(4)
		visit Item
		add_item_to_cart(4)
		expect(page.body).to  have_content("Already In the Cart")
	end


	def add_item_to_cart(number)
		click_link("Show", href: '/item/show/'+number.to_s)
		click_button("Add to Cart")
	end


	def create_item(number,price)
		visit Item
		click_link "Add New Item"
		page.fill_in 'item_item_name', :with => 'ItemNameTest'+ number.to_s
		page.fill_in 'item_price', :with => price
		page.fill_in 'item_description', :with => 'ItemDescriptionTest'+number.to_s
		page.fill_in 'item_inspiration', :with => 'ItemInspirationTest'+number.to_s
		click_button "Create Item"
	end

end