require 'rails_helper'
RSpec.feature "AddToCart", type: :feature do
	scenario 'Add To Cart (Guest)' do		# checks if a guest can add item
		item1 = FactoryGirl.create(:item)
		item2 = FactoryGirl.create(:item)
		add_item_to_cart(1)
		add_item_to_cart(2)		
		expect(page.body).to  have_content("added item")
	end

	scenario 'Add To Cart (LoggedInUser)' do		# checks if a user can add item
		user = FactoryGirl.create(:user)
		login_user(user)
		item1 = FactoryGirl.create(:item)
		item2 = FactoryGirl.create(:item)
		add_item_to_cart(3)
		add_item_to_cart(4)
		expect(page.body).to  have_content("added item")
	end

	scenario 'Add To Cart Already Added Item (Guest)' do		# checks if a guest can add item that's already in cart
		item1 = FactoryGirl.create(:item)
		item2 = FactoryGirl.create(:item)
		add_item_to_cart(5)
		add_item_to_cart(5)
		expect(page.body).to  have_content("Already In the Cart")
	end

	scenario 'Add To Cart Already Added Item (LoggedInUser)' do		# checks if a user can add item that's already in cart
		user = FactoryGirl.create(:user)
		login_user(user)
		item1 = FactoryGirl.create(:item)
		item2 = FactoryGirl.create(:item)
		add_item_to_cart(7)
		add_item_to_cart(7)
		expect(page.body).to  have_content("Already In the Cart")
	end

############################HELPERS####################################

	def add_item_to_cart(number)  # used to put an item in cart
		visit Item
		click_link("Show", href: '/item/show/'+number.to_s)
		click_button("Add to Cart")
	end

	def login_user(user)
		visit root_path
		click_button('LOGIN')
		page.fill_in 'user_uname' , :with => user.uname
		page.fill_in 'user_password' , :with => user.password
		click_button 'Log in'
		visit root_path
	end
########################END OF HELPERS###################################
end