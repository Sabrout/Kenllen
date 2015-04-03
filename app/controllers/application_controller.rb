class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_cart

	def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:uname, :email, :fname, :lname, :phone, :password ,:password_confirmation , :email_confirmation) }
    	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:uname, :password, :remember_me) }
  end

      def current_cart                      #retrieve the current cart id & if it doesn't exist then create a new cart and put id in session
      	Cart.find(session[:cart_id])
	       rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        	session[:cart_id] = cart.id
        return cart
      end

    def set_cart
      @cart = current_cart
    end
end
