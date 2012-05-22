class MessagesController < ApplicationController
  respond_to :html, :json

  # GET /messages
  def index
    respond_with do |format|
      format.html do
        @collection = Message.recent.for_display.all
        @message = Message.new
        session[:last_id] = @collection.last.id unless @collection.empty?
      end

      format.json do
        collection = Message.sent_after(session[:last_id] || 0).for_display
        render :json => {:collection => collection.map(&:as_hash)}
        session[:last_id] = collection.last.id unless collection.empty?
      end
    end
  end

  # POST /messages
  def create
    @message = current_user.messages.create(:text => params[:message][:text])
    respond_with do |format|
      format.html { redirect_to messages_path }
      format.json {
        render :json => {:collection => [@message.as_hash]}
        session[:last_id] = @message.id
      }
    end
  end
end
