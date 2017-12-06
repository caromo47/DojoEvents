class EventsController < ApplicationController
	before_action :require_login
  def index
		@events = Event.where(state: current_user.state)
		@other_events = Event.where.not(state: current_user.state)
  end

  def create
		@event = Event.new(event_params)
		@event.user = current_user
		if @event.valid?
			@event.save
			redirect_to :back
		else
			puts @event.errors.full_messages
			flash[:errors] = @event.errors.full_messages
			redirect_to :back
		end
  end

	def edit
		@event = Event.find(params[:event_id])
	end

	def update
		@event = Event.find(params[:event_id])
		if @event.update event_params
			redirect_to "/events"
			puts "update events"
		else
			puts @event.errors.full_messages
			flash[:errors] = @event.errors.full_messages
			redirect_to :back
		end
	end

  def destroy
		@event = Event.find(params[:event_id])
		@event.destroy if @event.user === current_user
		redirect_to :back
  end

  def show
		@comment = Comment.joins(:user).where(event: params[:event_id]).select(:first_name, :content)
		@attend = Attend.where(event: params[:event_id])
		@event = Event.joins(:user).find(params[:event_id])
  end
	private
		def event_params
			params.require(:event).permit(:name, :date, :location, :state)
		end
end
