class CommentsController < ApplicationController

	def create
		@event = Event.find(params[:event_id])
		@comment = @event.comments.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.valid?
			@comment.save
			puts @comment
			redirect_to :back
		else
			flash[:errors] = @comment.errors.full_messages
			redirect_to :back
		end
	end
	private
		def comment_params
			params.require(:comment).permit(:content)
		end
end
