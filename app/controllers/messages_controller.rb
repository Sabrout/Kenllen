class MessagesController < ApplicationController

  def inbox
    # checks if the current user is logged in or not, if not, he/she is redirected to the signin page
    if current_user == nil
      redirect_to new_user_session_path
    end
  end

  def sentbox
    # same as inbox... mainly for security reasons and to avoid errors
    if current_user == nil
      redirect_to new_user_session_path
    end
  end

  def send_trash
    # retreives the message ID passed from inbox view and sends it to trash
    @message = current_user.received_messages.find(params[:m_id])
    current_user.delete_message(@message)
    redirect_to trash_path
  end

  def create
    # on sending the message, the controller checks if the recepient exists, if he/she does exist, the message is sent
    # else the page is rendered with a flash notice telling the current user that this user doesnt exist
    @receiver = User.find_by(uname: params[:compose][:user])

    if @receiver == nil
      flash.keep[:notice] = 'No User exist with that username'
      redirect_to compose_path
    else
      current_user.send_message(@receiver, params[:compose][:subject], params[:compose][:body])
      redirect_to inbox_path
    end
  end

  def show
    # this method only marks the message as read
    @m_id = params[:m_id]
    current_user.received_messages.find(params[:m_id]).open
  end

  def reply
    # calls on the reply function to reply the message given to the sending user
    @body = params[:reply][:body]
    @message = current_user.received_messages.find(params[:r_id])
    current_user.reply_to(@message, params[:r_sub], params[:reply][:r_body])
    redirect_to inbox_path
  end

end

