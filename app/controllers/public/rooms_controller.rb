class Public::RoomsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @rooms = Room.all.order(:id)
    @room = Room.order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def destroy
    @message = Message.find(params[:message_id])
    room = Room.find(@message.room.id)
    @message.destroy
    redirect_to room_path(room.id)
  end

  private

  def rooms_params
    params.require(:room).permit(:room_name,:room_image)
  end
end