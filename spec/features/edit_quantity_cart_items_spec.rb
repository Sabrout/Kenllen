require 'rails_helper'

RSpec.feature "EditQuantityCartItems", type: :feature do
	
	scenario 'Edit Cart Quantity with value less than InStock(Guest)' do		# checks if a guest can edit a quantity with value less than 
		item1 = FactoryGirl.create(:item)
		add_item_to_cart(9)
		page.fill_in 'cart_quantity' , :with => 2
		click_button 'Update'
		expect(find_field('cart_quantity').value).to eq "2"
		#should contain new quantity
	end

	scenario 'Edit Cart Quantity with value less than InStock(LoggedInUser)' do		# checks if a user can edit a quantity with value less than 
		user = FactoryGirl.create(:user)
		login_user(user)
		item1 = FactoryGirl.create(:item)
		add_item_to_cart(10)
		page.fill_in 'cart_item_quantity' , :with => 2
	    click_button 'Update'
	    expect(find_field('cart_item_quantity').value).to eq "2"
		#should contain new quantity
	end

	scenario 'Edit Cart Quantity with value equals InStock(Guest)' do		# checks if a guest can edit a quantity with value equal in stock 
		item1 = FactoryGirl.create(:item)
		add_item_to_cart(11)
		page.fill_in 'cart_quantity' , :with => 6
		click_button 'Update'
		expect(find_field('cart_quantity').value).to eq "6"
		#should change quantity field then click update button
		#should contain new quantity
	end

	scenario 'Edit Cart Quantity with value equals InStock(LoggedInUser)' do		# checks if a user can edit a quantity with value equal in stock 
		user = FactoryGirl.create(:user)
		login_user(user)
		item1 = FactoryGirl.create(:item)
		add_item_to_cart(12)
		page.fill_in 'cart_item_quantity' , :with => 6
	    click_button 'Update'
	    expect(find_field('cart_item_quantity').value).to eq "6"
		#should change quantity field then click update button
		#should contain new quantity
	end

	scenario 'Edit Cart Quantity with value Greater Than InStock(Guest)' do		# checks if a guest can edit a quantity with value greater than in stock 
		item1 = FactoryGirl.create(:item)
		add_item_to_cart(13)
		page.fill_in 'cart_quantity' , :with => 7
		click_button 'Update'
		expect(find('.cartError')).to be_present
		#should change quantity field then click update button
		#should contain new quantity
	end

	scenario 'Edit Cart Quantity with value Greater Than InStock(LoggedInUser)' do	# checks if a user can edit a quantity with value greater than in stock 
		user = FactoryGirl.create(:user)
		login_user(user)
		item1 = FactoryGirl.create(:item)
		add_item_to_cart(14)
		page.fill_in 'cart_item_quantity' , :with => 7
	    click_button 'Update'
	    expect(find('.cartError')).to be_present
		#should change quantity field then click update button
		#should contain new quantity
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
