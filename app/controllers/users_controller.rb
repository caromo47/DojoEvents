class UsersController < ApplicationController
	before_action :require_correct_user, only: [:update, :show, :edit, :destroy]
	before_action :require_login, only: [:update, :edit, :destroy, :show]
	def create
		@user = User.new(user_params)
		if @user.valid?
			@user.save
			session[:user_id] = @user.id
			redirect_to '/events'
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to :back
		end
  end

	def update
		@user = User.find(params[:user_id])
		if @user.update user_params
			redirect_to "/events"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to :back
		end
  end

	def edit
		@user = User.find(params[:user_id])
	end

	private
		def require_correct_user
			if current_user != User.find(params[:user_id])
				redirect_to "/users/#{session[:user_id]}"
			end
		end

		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :state, :location, :password, :password_confirmation)
		end
end
