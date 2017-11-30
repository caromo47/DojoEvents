class AttendsController < ApplicationController
  def create
		event = Event.find(params[:event_id])
		Attend.create(user: current_user, event: event)
		redirect_to '/events'
  end

	def destroy
		event = Event.find(params[:event_id])
		Attend.find_by(user: current_user, event: event).destroy
		redirect_to '/events'
	end
end
