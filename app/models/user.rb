class User < ActiveRecord::Base
  self.table_name = 'users'                         #setting referenced table in db
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:omniauthable, :validatable
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

 TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable


  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
