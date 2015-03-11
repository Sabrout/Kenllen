class User < ActiveRecord::Base
    attr_accessor :remember_token #getter and setter for remember_token
    self.table_name = 'users'                         #setting referenced table in db
    has_secure_password                               #bcrypt method to hash password
    validates :fname , :presence => {:message => "^Firsname Field Cannot be blank"} , :length => { :maximum => 12 , :message => "^Firstname Is Too Long(maximum is 12 characters)" }  #sets the maximum length of first name to 12
    validates :lname , :presence => {:message => "^Lastname Field Cannot be blank"} , :length => { :maximum => 12 , :message => "^Lastname Is Too Long(maximum is 12 characters)"}  #sets the maximum length of last name to 12
    validates :uname , :presence => {:message => "^Username Field Cannot be blank"} , :uniqueness => { case_sensitive: false , :message => "^Username Already Taken" }, :length => { :minimum => 4, :message => "^Username Is Too Shot (minimum is 4 characters)" } #sets the maximum length of user name to 12 and minimum to 4
    validates :uname , :length => {:maximum => 12 , :message => "^Username Is Too long (maximum is 12 characters)"}
    validates :phone , :presence => {:message => "^Phone Field Cannot be blank"}, :length => { :maximum => 12 , :message => "^PhoneNumber Is Too Long(maximum is 12 numbers)" } #sets the maximum length of phone to 12
    validates :password , :length => { :minimum => 6, :maximum => 12 } #sets the maximum length of password to 12 and minimum to 6
    validates :email ,uniqueness: {:message => "^Email Already Registerd"}, :format => { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates_confirmation_of :email , :allow_blank => true
end