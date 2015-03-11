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

end