class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :banned?
  helper_method :reported?
  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:uname, :email, :fname, :lname, :phone, :password ,:password_confirmation , :email_confirmation) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:uname, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:reports , :banned) }
  end

      def banned? # check if a user is banned or not and kicks him/her in case column ban has true value in it
        if current_user.present? && current_user.banned
          sign_out current_user
          redirect_to root_path, :notice => "This account has been suspended...."
        end
      end

      def current_cart                      #retrieve the current cart id & if it doesn't exist then create a new cart and put id in session
            if (current_user.cart)
              if (session[:temporary_cart])
                move_temp_to_current(current_user.cart)
              end
              return current_user.cart
            else
              cart = Cart.create  
              current_user.cart = cart  #save user id in cart record
              if(session[:temporary_cart])
                flash[:notice] = 'updated current cart'
                move_temp_to_current(cart)
              end
              return cart
            end
      end
      
      def temporary_cart        # create a temporary cart or retrieve the existing one in session
        if (!current_user)
           session[:temporary_cart] = Hash.new if !session[:temporary_cart]
           return session[:temporary_cart]
        end
      end

      def reported?(item_id , user_id) # check if a user has reported this item before
       return ItemReport.exists?(item_id:item_id , user_id: user_id)
      end

      private 

      def move_temp_to_current(cart)    # moves the items from temporary cart to the currently used cart
          old_cart = session[:temporary_cart]
          old_cart.each do |cartItem|
            item_id = cartItem[0].to_i
            item = Item.find(item_id)
            cart_item = cart.cart_items.create(item: item)
            cart_item.update_attributes(quantity: cartItem[1][1])
          end
          session[:temporary_cart] = nil
      end
end
