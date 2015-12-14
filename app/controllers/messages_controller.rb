class MessagesController < ApplicationController

  before_action :check_login

  def index
    @messages = current_user.received_messages.reverse_order
  end

  def outbox
    @messages = current_user.sent_messages.reverse_order
  end

  def show
    @message = Message.find(params[:id])
    unless @message.read
      @message.read = true
      @message.save
    else
      @message = nil
      flash[:error] = "You already view the content of this message."
    end
  end

  def new
    @friends = current_user.friends.collect{|f| f.to}
  end

  def create
      @message = Message.new(message_params)
      @message.sender = current_user
      @message.receiver = User.find(message_params[:receiver_id])

      if @message.save
        redirect_to messages_path
      else
        render 'new'
      end
  end

  private
  def message_params
    params.require(:message).permit(:body, :receiver_id)
  end
end
