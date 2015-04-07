class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
<<<<<<< HEAD
  before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:uname, :email, :fname, :lname, :phone, :password ,:password_confirmation , :email_confirmation) }
    	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:uname, :password, :remember_me) }
    end
=======

  include SessionsHelper

>>>>>>> 9eb8d49f40f0a3c5332a5a5b3a218fa373904d29
end
