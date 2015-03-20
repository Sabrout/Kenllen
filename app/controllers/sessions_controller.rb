class SessionsController < ApplicationController

def create
user = User.new(uname: params[:signup][:uname] ,password: params[:signup][:password],
            fname: params[:signup][:fname] ,lname: params[:signup][:lname] ,
            email: params[:signup][:email] ,phone: params[:signup][:phone] )
	if (user.save) 
    UserMailer.account_activation(user).deliver_now  
      flash[:info] = "Please check your email to activate your account."   
      redirect_to '/'
      else
      render 'view_signup'
	end         
end
def view_signup

end

def view_signin

end

def login
user = User.find_by(uname: params[:session][:uname])
if user && user.authenticate(params[:session][:password])
log_in(user)
params[:session][:remember_me] == '1' ? remember(user) : forget(user)
flash[:success] = 'Welcome To KnellenArts , Please Check Your Email Account to Activate Your Knellen Account'
else
flash[:error] = 'Invalid Username/password combination'
end
if logged_in?
	redirect_to '/'
else
    render 'view_signin'
end

end


def logout
	log_out
	redirect_to '/'
end

end