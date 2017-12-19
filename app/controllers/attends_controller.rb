class AttendsController < ApplicationController

	def create
		attend = Attend.create(attend_params)
		if attend.valid?
			return redirect_to event_index_path
		end
		flash[:errors] = attend.errors.full_messages
		return redirect_to :back
	end

	def destroy
		attend = Attend.where(event_id: params[:event_id], user_id: session[:user_id])
	end

	private
		def attend_params
			params.require(:attend).permit(:event_id).merge(user_id: session[:user_id])
end
