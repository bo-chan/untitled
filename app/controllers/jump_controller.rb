class JumpController < ApplicationController
  def index
   # @entry_chat = EntryChat.find(params[:id])
    $chat_id = params[:id]
    redirect_to '/chat_comments/index'
  end
end
