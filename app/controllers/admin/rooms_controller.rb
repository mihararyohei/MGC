class Admin::RoomsController < ApplicationController
  def index
    @room = Room.new
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(rooms_params)
    @room.category_id = Category.find_by(category_name: params[:room][:category_name]).id
    if @room.save
       redirect_to admin_rooms_path
    else
      @rooms = Room.all
      render :index
    end
  end

  def update
    @room = Room.find(params[:id])
    @room.category_id = Category.find_by(category_name: params[:room][:category_name]).id
    if @room.update(rooms_params)
       redirect_to admin_rooms_path
    else
      render :edit
    end
  end

  def destroy
    @message = Message.find(params[:message_id])
    room = Room.find(@message.room.id)
    @message.destroy
    redirect_to admin_room_path(room.id)
  end

  def destroy_all
    @room = Room.find(params[:room_id])
    @room.destroy
    redirect_to admin_rooms_path
  end

  private

  def rooms_params
    params.require(:room).permit(:room_name,:room_image,:category_id)
  end
end