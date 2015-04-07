class User < ActiveRecord::Base
  self.table_name = 'users'                         #setting referenced table in db
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
    has_many :shops , dependent: :destroy
    has_one :cart , dependent: :destroy
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
end