require 'rails_helper'

RSpec.feature "RemoveCartItems", type: :feature do
	
	scenario 'Remove From Cart (Guest)' do		# checks if a guest can delete item
		item1 = FactoryGirl.create(:item)
		item2 = FactoryGirl.create(:item)
		item3 = FactoryGirl.create(:item)
		add_item_to_cart(15)
		add_item_to_cart(16)
		add_item_to_cart(17)
		first('.button_to').click_button('Delete')
		expect(page).to have_selector('.item-body', count: 2)	
	end

	scenario 'Add To Cart (LoggedInUser)' do		# checks if a user can delete item
	 	user = FactoryGirl.create(:user)
		login_user(user)
	 	item1 = FactoryGirl.create(:item)
	 	item2 = FactoryGirl.create(:item)
	 	item3 = FactoryGirl.create(:item)
	 	add_item_to_cart(18)
	 	add_item_to_cart(19)
	 	add_item_to_cart(20)		
	 	first('.button_to').click_button('Delete')
		expect(page).to have_selector('.item-body', count: 2)
	end

	scenario 'Clear Cart (Guest)' do		# checks if a guest can clear his cart
		item1 = FactoryGirl.create(:item)
		item2 = FactoryGirl.create(:item)
		item3 = FactoryGirl.create(:item)
		add_item_to_cart(21)
		add_item_to_cart(22)
		add_item_to_cart(23)
		click_button('Clear Cart')
		expect(page).to have_selector('.item-body', count: 0)	
	end

	scenario 'Clear Cart (LoggedInUser)' do		# checks if a user can clear his cart
	 	user = FactoryGirl.create(:user)
		login_user(user)
		item1 = FactoryGirl.create(:item)
		item2 = FactoryGirl.create(:item)
		item3 = FactoryGirl.create(:item)
		add_item_to_cart(24)
		add_item_to_cart(25)
		add_item_to_cart(26)
		click_button('Clear Cart')
		expect(page).to have_selector('.item-body', count: 0)	
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
