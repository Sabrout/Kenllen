require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
	it 'should sign up a user then redirects to home' do
		post :create , user: {uname: 'username' ,fname: 'firstname' ,
		lname: 'lastname' ,email: 'email@email.email' ,phone: '123456' ,
		password: 'password'}
		expect(response).to redirect_to(root_path)
	end

	it 'should refresh the same page as the sign up fails' do
		post :create , user: {signup:{uname: 'username'}}
		expect(response).to render_template(:view_signup)
	end
end
