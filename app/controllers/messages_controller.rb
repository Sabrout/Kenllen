class MessagesController < ApplicationController

  def show
  end

  def inbox

  	if current_user == nil
  		redirect_to new_user_session_path
  	end

  end

  def trash
  end

  def new
  end

  def create
  	@receiver = User.find_by(uname: params[:compose][:user])

  	if @receiver == nil
  		flash.keep[:notice] = 'No User exist with that username'
  		redirect_to compose_path
  	else
  		current_user.send_message(@receiver, params[:compose][:subject], params[:compose][:body])
  		redirect_to inbox_path
  	end
  end

end

