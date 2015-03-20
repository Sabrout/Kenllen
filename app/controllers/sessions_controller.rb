class SessionsController < ApplicationController

<<<<<<< HEAD

def create #creates a new user from the values passed to signup hash and stores it in the db and redirects the user to the home page if successful else refresh the signup page
@user = User.new(user_params)
	if (@user.save) #check if user insertion was done correctly
      flash.now[:notic] = "Successfully Registered !!"  
      
      redirect_to '/'
      else
      render 'view_signup'
	end         
end

def view_signup #used to generate the view for it , for the signup form
@user = User.new
end


private

    def user_params
      params.require(:user).permit(:uname, :email, :email_confirmation, :password,
                :password_confirmation, :fname, :lname, :phone )
    end
end