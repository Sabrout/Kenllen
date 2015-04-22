class ConversationsController < ApplicationController
	before_filter :authenticate_user!
  	helper_method :mailbox, :conversation
  	before_action :mailbox

  	#listing all conversations inside inbox
  	def index 
    	@conversations = @mailbox.inbox.all
  	end

  	def trashbin     
  		@trash ||= current_user.mailbox.trash.all   
 		# end
	end
	def trash
 		conversation.move_to_trash(current_user)
 		redirect_to :conversations
	end

	def untrash
 		conversation.untrash(current_user)
 		redirect_to :back
	end

	def empty_trash
 		current_user.mailbox.trash.each do |conversation|
   		# conversation.receipts_for(current_user).update_all(:deleted =< true)
  		end
 		redirect_to :conversations
	end

	private
 
	def mailbox
 		@mailbox = current_user.mailbox
	end
 
	def conversation
 		@conversation = mailbox.conversations.find(params[:id])
	end

end
