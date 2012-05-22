class MessagesController < ApplicationController
  def index
    @collection = Message.includes(:user).order('created_at DESC').limit(20).all
    session[:update_time] =  Time.new
	  @message = Message.new
  end

  def update
    t = session[:update_time]
    session[:update_time] =  Time.new
  	collection = Message.includes(:user).order('created_at DESC').where(['created_at >= ?', t]).all
  	ret_collection = collection.map {|msg| {:text => msg.text, :user_name => msg.user.name} }
  	render :json => {:collection =>  ret_collection}
  end

  def add
    usr = User.where(:id => session[:user_id]).first
  	txt = params[:message][:text]
    usr.messages.create(:text => txt) unless usr.nil? || txt.blank?
	  redirect_to :action => 'index'
  end
end
