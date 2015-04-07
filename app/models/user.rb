class User < ActiveRecord::Base
<<<<<<< HEAD
  self.table_name = 'users'                         #setting referenced table in db
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
    has_many :shops , :dependent => :destroy

    validates :fname , :presence => {:message => "Firsname Field Cannot be blank"}
    validates :fname , :length => { :maximum => 12 , :message => "Firstname Is Too Long(maximum is 12 characters)" }  #sets the maximum length of first name to 12

    validates :lname , :presence => {:message => "Lastname Field Cannot be blank"} 
    validates :lname , :length => { :maximum => 12 , :message => "Lastname Is Too Long(maximum is 12 characters)"}  #sets the maximum length of last name to 12

    validates :uname , :presence => {:message => "Username Field Cannot be blank"} 
    validates :uname , :allow_blank => true , :length => {:maximum => 12 , :message => "Username Is Too long (maximum is 12 characters)"} #sets the maximum length of user name to 12
    validates :uname , :allow_blank => true , :uniqueness => { case_sensitive: false , :message => "Username Already Taken" } # validate uniqueness
    validates :uname , :allow_blank => true , :length => { :minimum => 4, :message => "Username Is Too Shot (minimum is 4 characters)" } #sets the minimum length of user name to 4

    validates :phone , :presence => {:message => "Phone Field Cannot be blank"}, :length => { :maximum => 12 , :message => "PhoneNumber Is Too Long(maximum is 12 numbers)" } #sets the maximum length of phone to 12
    validates :password , :presence => { :message => "Password Field Can't Be Blank"} #password can't be blank
    validates :password , :allow_blank => true , :length => { :maximum => 12 , :message => "Password Is Too Long(maximum is 12 characters)"} #sets the maximum length of password to 12
    validates :password , :allow_blank => true , :length => { :minimum => 6, :message => "Password Is Too SHORT(minimum is 6 characters)"} #sets the minimum length of password to 6
    validates_confirmation_of :password, {:message => "These passwords don't match."}


    validates :email ,:presence => {:message => "Email Can't Be Blank"}
    validates :email ,:allow_blank => true ,:uniqueness => {:message => "Email Already Registerd"}
    validates_confirmation_of :email, {:message => "Please , Re-enter Your Email"}

    mount_uploader :image , ImageUploader
=======

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

def remember # call the new token function to generate the string and then call the digest to hash that string

    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
end

def User.new_token  # create a random string
    SecureRandom.urlsafe_base64
end


def User.digest(string) # hash the string (the token)

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


def forget
    update_attribute(:remember_digest, nil)
end

>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
end