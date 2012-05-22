class UsersController < ApplicationController
	# GET /users
	def index
		@user = User.new
	end

	# POST /users
	def create
		user_name = params[:user][:name]

		User.find_or_create_by_name(user_name).tap do |user|
			if user.valid?
				session[:user_id] = user.id
				redirect_to "/messages"
			else
				session[:user_id] = nil
				redirect_to root_path
			end
		end
	end
end
