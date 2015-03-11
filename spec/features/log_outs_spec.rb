require 'rails_helper'

RSpec.feature "LogOuts", type: :feature do

  scenario 'logout a logged in user' do
    user = User.create(uname: "username" , fname: "firstname" , lname: "lastname",
		password: "password" , email: "email@email.email", phone: '123')
        sign_in_with user.uname , user.password
        click_button 'Logout'
        expect(page).to have_button('LOGIN')
  end

  scenario 'logout a logged out user' do
       expect(page).not_to have_button('Logout')
  end

  def sign_in_with(uname,password)
    visit login_path
    find("input[placeholder='User Name']").set uname
    find("input[placeholder='Password']").set password
    click_button 'Log in'
  end
end
