class MessagesController < ApplicationController
  respond_to :html, :json

  # GET /messages
  def index
    respond_with do |format|
      format.html do
        @collection = Message.recent.for_display.all
        @message = Message.new
        session[:update_time] = Time.new
      end

      format.json do
        collection = Message.sent_after(session[:update_time]).for_display.map(&:as_hash)
        render :json => {:collection => collection}
        session[:update_time] = Time.new
      end
    end
  end

  # POST /messages
  def create
    current_user.messages.create(:text => params[:message][:text])
    redirect_to messages_path
  end
end
