class MessagesController < ApplicationController

  # before_filter :authenticate_user!

	# GET /message/new
  def new
    # @user = User.find(params[:user])
    # @message = current_user.messages.new
  end
 
   # POST /message/create
   # create a new message and sends it from current_user to the recipient given in the parameters
  def create

    @recipient = User.find_by(uname: params[:new_message][:runame])
    # @recipient = User.find_by(one_param)
    if @recipient != nil
    current_user.send_message(@recipient, params[:new_message][:body], params[:new_message][:subject])
    # current_user.send_message(message_params)
    # flash[:notice] = 'Message has been sent!'
    # redirect_to :conversations
    # redirect_to root_path
    else
      flash[:alert] = 'Message Failed'
      # redirect_to root_path
    end
    # redirect_to conversations_inbox_path
  end

#   def create
#     recipients = User.where(id: params['recipients'])
#     conversation = @current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
#     flash[:success] = "Message has been sent!"
#     redirect_to conversation_path(conversation)
#   end

  # left temporarly to redirecting the view
  def index

    # redirect_to root_path
    redirect_to :conversations

  end

end

