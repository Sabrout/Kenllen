class UserController < ApplicationController

  def signUp

  	
  end

  def signin

  end

  def goSignUp

  	redirect_to (sign_me_up_path)

  end

  def create

  	newuser = User.new(lname: params[:user][:lname], fname: params[:user][:fname], uname: params[:user][:uname], email: params[:user][:email], 
  		password: user.authenticate(params[:user][:password]), address: params[:user][:address], phone: params[:user][:phone])
  	# 	 , created_at: Time.now.to_i, updated_at: Time.now.to_i)
#	newuser = User.new(params.require(:user).permit(:fname,:lname,:unmae,:password,:email,:address,:phone))
  	if newuser.save  
  			redirect_to (home_users_path)

  	else 
  		render 'signUp'
  	end

  end

  def login

  	#@current_user = params[:Session]
  	cu = User.find_by(uname: params[:Session][:unamelogin])
  	if (cu.password == hashedpassword.authenticate?(params[:Session][:passwordlogin]))
  		redirect_to home_users_path
  	else
  		redirect_to (sign_me_up_path)
  	end

  end

end