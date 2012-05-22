class UsersController < ApplicationController
	def login
		@user = User.new
	end
	
	def add
	    user_name = params[:user][:name]
		if user_name.blank?
			redirect_to :action => 'login'
			return
		end
		usr = User.where(:name => user_name).first
		usr = User.create(:name => user_name) if usr.nil?
		session[:user_id] = usr.id
		redirect_to :controller => 'messages', :action => 'index'
	end
end
