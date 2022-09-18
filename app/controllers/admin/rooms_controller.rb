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
    if @room.save
       redirect_to admin_rooms_path
    else
      @rooms = Room.all
      render admin_rooms_path
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(rooms_params)
       redirect_to admin_rooms_path
    else
      render edit_admin_room_path(room.id)
    end
  end

  # def destroy
  #   @model_class_name = ModelClassName.find(params[:id])
  #   @model_class_name.destroy

  #   respond_to do |wants|
  #     wants.html { redirect_to(model_class_names_url) }
  #     wants.xml  { head :ok }
  #   end
  # end

  private

  def rooms_params
    params.require(:room).permit(:room_name,:room_image)
  end
end
