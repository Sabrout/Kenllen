require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  scenario 'sign up with valid info' do
  sign_up_with 'first name' , 'last name' , 'user name' ,'123','example@example.com', 'password'
  expect(page.title).to match(/Home/)
  end
  
  scenario 'sign up with invalid info' do
    sign_up_with '' , '' , 'user name' ,'123','example@example.com', 'password'
   expect(page.title).to match(/SignUp/)
  end


 def sign_up_with(fname,lname,uname,phone,email, password)
    visit sign_up_path
    find("input[placeholder='First Name']").set fname
    find("input[placeholder='Last Name']").set lname
    find("input[placeholder='User Name']").set uname
    find("input[placeholder='Phone Number']").set phone
    find("input[placeholder='example@domain.com']").set email
    find("input[placeholder='Confirm email']").set email
    find("input[placeholder='Password']").set password
    find("input[placeholder='Confirm Password']").set password
    click_button 'Sign up'
  end
end
