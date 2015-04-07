require 'rails_helper'

RSpec.describe User, type: :model do
    it 'should generate string' do
    	puts User.new_token
    end

    it 'should hash tokens' do
    	puts User.digest(User.new_token)
    end

    it 'should compare a hash in database with its string' do
    	token = User.new_token
    	hashed_token = User.digest(token)
    	user = User.create(uname: "username" , fname: "firstname" , lname: "lastname",
		 password: "password" , email: "email@email.email", phone: '123456' , remember_digest: hashed_token)
        expect(user.authenticated?(token)).to be(true)
    end

    it 'should delete a hashed_token from the database' do
    	token = User.new_token
    	hashed_token = User.digest(token)
    	user = User.create(uname: "username" , fname: "firstname" , lname: "lastname",
		password: "password" , email: "email@email.email", phone: '123456' , remember_digest: hashed_token)
        expect(user.forget).to be(true)
        expect(user.remember_digest).to be_nil
    end

    it 'should store a hashed_token in database' do
    	user = User.create(uname: "username" , fname: "firstname" , lname: "lastname",
		password: "password" , email: "email@email.email", phone: '123456')
		expect(user.remember).to be(true)
	    expect(user.remember_digest).to be 
    end


end
