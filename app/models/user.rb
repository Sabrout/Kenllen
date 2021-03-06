class User < ActiveRecord::Base
  self.table_name = 'users'                         #setting referenced table in db
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable , :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]
   ratyrate_rater

  # adds the messaging service from acts-as-messageable to this model 
  acts_as_messageable :dependent => :destroy

  #allows users to add comments
  acts_as_commontator

         # Associations
    has_many :shops , :dependent => :destroy
    has_one :cart , dependent: :destroy
    has_and_belongs_to_many :followed_shops, class_name: "Shop", join_table: "shops_users"
    has_and_belongs_to_many :reported_items, class_name: "Item", join_table: "items_reports"

    validates :fname , :presence => {:message => "Firsname Field Cannot be blank"} , :on => :create
    validates :fname , :length => { :maximum => 12 , :message => "Firstname Is Too Long(maximum is 12 characters)" }  #sets the maximum length of first name to 12

    validates :lname , :presence => {:message => "Lastname Field Cannot be blank"} , :on => :create
    validates :lname , :length => { :maximum => 12 , :message => "Lastname Is Too Long(maximum is 12 characters)"}  #sets the maximum length of last name to 12

    validates :uname , :presence => {:message => "Username Field Cannot be blank"} , :on => :create
    validates :uname , :allow_blank => true , :length => {:maximum => 12 , :message => "Username Is Too long (maximum is 12 characters)"} #sets the maximum length of user name to 12
    validates :uname , :allow_blank => true , :uniqueness => { case_sensitive: false , :message => "Username Already Taken" } # validate uniqueness
    validates :uname , :allow_blank => true , :length => { :minimum => 4, :message => "Username Is Too Shot (minimum is 4 characters)" } #sets the minimum length of user name to 4

    validates :phone , :length => { :maximum => 12 , :message => "PhoneNumber Is Too Long(maximum is 12 numbers)" } , :on => :create #sets the maximum length of phone to 12
    validates :password , :presence => { :message => "Password Field Can't Be Blank"} , :on => :create #password can't be blank
    validates :password , :allow_blank => true , :length => { :maximum => 12 , :message => "Password Is Too Long(maximum is 12 characters)"} #sets the maximum length of password to 12
    validates :password , :allow_blank => true , :length => { :minimum => 6, :message => "Password Is Too SHORT(minimum is 6 characters)"} #sets the minimum length of password to 6
    validates_confirmation_of :password, {:message => "These passwords don't match."}


    validates :email ,:presence => {:message => "Email Can't Be Blank"} , :on => :create
    validates :email ,:allow_blank => true ,:uniqueness => {:message => "Email Already Registerd"}
    validates_confirmation_of :email, {:message => "Please , Re-enter Your Email"}

    # mount_uploader :image , ImageUploader

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,11]
            user.uname = auth.info.name   # assuming the user model has a name
            user.fname = auth.info.first_name
            user.lname = auth.info.last_name
            user.skip_confirmation! 
        end
    end
end