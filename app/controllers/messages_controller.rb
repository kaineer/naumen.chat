class MessagesController < ApplicationController
  def index
    @collection = Message.recent.all
    session[:update_time] =  Time.new
	  @message = Message.new
  end

  def update
    t = session[:update_time]
    session[:update_time] =  Time.new
    collection = Message.sent_after(t).all
  	render :json => {:collection => collection.map(&:as_hash)}
  end

  def add
    usr = User.where(:id => session[:user_id]).first
  	txt = params[:message][:text]
    usr.messages.create(:text => txt) unless usr.nil? || txt.blank?
	  redirect_to :action => 'index'
  end
end
