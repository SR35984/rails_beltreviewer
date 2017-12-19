class EventsController < ApplicationController

	def index
		@user = User.find(session[:user_id])
		@localevents = Event.where(state: @user.state)
		@otherevents = Event.where.not(state: @user.state)
	end

	def create
		event = Event.create(event_params)
		if event.valid?
			return redirect_to event_index_path
		end
		flash[:errors] = events.errors.full_messsges
		return redirect_to :back
	end

	def show
		@event = Event.find(params[:id])
		@joins = @event.attends
	end

	def delete

	end

	private
		def event_params
			params.require(:event).permit(:name, :date, :location, :state).merge(user_id: session[:user_id])
		end
end
