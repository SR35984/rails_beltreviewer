class UsersController < ApplicationController

	def index
	end

	def create
		user = User.create(user_params)
		if user.valid?
			session[:user_id] = user.id
			return redirect_to event_index_path
		elsif
			flash[:errors] = user.errors.full_messages
			return redirect_to :back
		end
	end

	def login
		user = User.find_by(email: params[:email])
		if user
			if user.try(:authenticate, params[:password])
				session[:user_id] = user.id
				return redirect_to event_index_path
			end
			flash[:errors] = ['Password is incorrect']
		else
			flash[:errors] = ['Email is incorrect']
		end
		return redirect_to :back
	end

	def edit
		@user = User.find(session[:user_id])
	end

	def update
		user = User.find(session[:user_id]).update(user_params)
		redirect_to user_path user.id
	end

	def logout
		reset_session
		redirect_to user_index_path
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
		end
end