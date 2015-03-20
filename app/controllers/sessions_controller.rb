class SessionsController < ApplicationController


def login #logs in the user
user = User.find_by(uname: params[:session][:uname]) #checks if the user name provided by user exists in db
if user && user.authenticate(params[:session][:password]) #checks if the password provided matches the user password and that the username exist in the db
log_in(user) #calls log_in that exists in session_helper
params[:session][:remember_me] == '1' ? remember(user) : forget(user) #checks if the user wants to be remembered on his pc or not
flash.now[:success] = 'Welcome To KnellenArts , Please Check Your Email Account to Activate Your Knellen Account' #simple success message
end

if logged_in? #calls logged_in? that exists in session_helper 
	redirect_to '/' #redirect to home
else
    render 'view_signin' #refresh page
end

end


def logout #logs user out
	log_out if logged_in?#calls log_out (exists in sessions_helper)
	redirect_to '/' #redirect logged out user to home
end

def view_signin

end

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