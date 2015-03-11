require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
	it 'should set session id to user_id(test log_in)' do 
    	user = sign_up
		user_id = user.user_id
    	log_in(user)
    	id = session[:user_id]
    	expect(user_id).to be(id)
	end

	it 'should retrieve the logged in user object if logged in without a token(test current user)' do
       user = sign_up
       log_in(user)
       expect(current_user.user_id).to be(user.user_id)
	end
    
     
	it 'should retrieve the logged in user object if logged in with a token' do
       user = sign_up_token_given
       expect(current_user.user_id).to be(user.user_id)
	end

	it 'should return null(no user logged in)' do
       expect(current_user).to be(nil)
	end
    
    it 'should return true(test logged_in?)' do
    expect(logged_in?).to be(false)
    end

    it 'should return false(test logged_in?)' do
    user = sign_up
    log_in(user)
    expect(logged_in?).to be(true)
    end

    it 'should log out logged in user without cookies' do
     user = sign_up
     log_in(user)
     log_out
     expect(current_user).to be(nil)
    end
    
    it 'should log out logged in user with cookies' do
    user = sign_up_token_given
    forget(user)
    expect(current_user).to be(nil)
    end

	def sign_up
     user = User.create(uname: "username" , fname: "firstname" , lname: "lastname",
	 password: "password" , email: "email@email.email", phone: '123456')
	end

	def sign_up_token_given
    	user = User.create(uname: "username" , fname: "firstname" , lname: "lastname",
		 password: "password" , email: "email@email.email", phone: '123456')
    	remember(user)
    	return user
	end
end
