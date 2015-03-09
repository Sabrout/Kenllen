class User < ActiveRecord::Base
	attr_accessor :remember_token , :activation_token #getter and setter for remember_token , activation_token both are used to hold values to pass them later , they don't exist in db
	self.table_name = 'users'                         #setting referenced table in db
	has_secure_password                               #bcrypt method to hash password
    validates_length_of :fname , maximum: 12          #sets the maximum length of first name to 12
    validates_length_of :lname , maximum: 12          #sets the maximum length of last name to 12
    validates_length_of :uname , minimum: 4 , maximum: 12 #sets the maximum length of user name to 12 and minimum to 4
    validates_length_of :password , minimum: 6 , maximum: 12 #sets the maximum length of password to 12 and minimum to 6
    validates_length_of :phone , maximum: 12 #sets the maximum length of phone to 12
    before_create :create_activation_digest #makes sure that user isn't inserted unless an activation token is generated

def remember # calls the new token function to generate the string and then call the digest to hash that string
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
end

def User.new_token  # create a random string
    SecureRandom.urlsafe_base64
end

def User.digest(string) # hashes the string (the token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
end

def authenticated?(remember_token) #makes sure that the token matches the hashed one in db
    if remember_digest.nil?
    	return false
    else
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
end

def forget #delete the remember digest field from the database
    update_attribute(:remember_digest, nil)
end

private

def create_activation_digest #calls new token for each user to generate a string then calls digest to hash that string
self.activation_token = User.new_token #generates a token and gives it to user (activation token isn't in db , it's just used to hold the token till storing it in cookie)
self.activation_digest = User.digest(activation_token) #hashes that token and store it in db
end


end