require 'rails_helper'

RSpec.feature "SignIns", type: :feature do
    
	scenario 'sign in with invalid info' do
		user = User.create(uname: "username" , fname: "firstname" , lname: "lastname",
		 password: "password" , email: "email@email.email", phone: '123')
        sign_in_with user.uname , user.password
        expect(page).to have_content('WELCOME')
	end

    scenario 'sign in with invalid info' do
  		sign_in_with 'user name' , 'password'
  		expect(page).to have_content('Login')
 	 end



  def sign_in_with(uname,password)
    visit login_path
    find("input[placeholder='User Name']").set uname
    find("input[placeholder='Password']").set password
    click_button 'Log in'
  end
end
