class MessagesController < ApplicationController
  def create
    message = Message.create(message_params)
    redirect_to "/posts/#{message.post.id}"
  end

  private
  def message_params
    params.require(:message).permit(:message).merge(post_id: params[:post_id])
  end
end
