class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    # 自分がいるチャットルームを取得
    current_user_chat_rooms = ChatRoomUser.where(user_id :current_user.id).map(|chatroomuser| chatroomuser.chat_room)
    # 自分がいるチャットルームからマッチング一覧ページからクリックしたユーザーがいるチャットルームを取得
    chat_room = ChatRoomUser.where(chat_room: current_user_chat_rooms, user_id: params[:user_id]).map(|chatroomuser| chatroomuser.chat_room).first
    if chat_room.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room: chat_room,user_id: current_user.id)
      ChatRoomUser.create(chat_room: chat_room,user_id: params[:user_id])
    end
    redirect_to action: :show, id: chat_room.id
  end

  def show
  end


end
