class Public::BookmarksController < ApplicationController
  before_action :ensure_correct_customer

  def index
    @rooms = current_customer.rooms.order(created_at: :desc)
    @bookmarks = current_customer.bookmarked_rooms
  end

  def create
    room = Room.find(params[:room_id])
    bookmark = current_customer.bookmarks.new(room_id: room.id)
    bookmark.save
    redirect_to rooms_path
  end

  def destroy
    room = Room.find(params[:room_id])
    bookmark = current_customer.bookmarks.find_by(room_id: room.id)
    bookmark.destroy
    redirect_back(fallback_location: root_path)
  end

  def ensure_correct_customer
    @customer = current_customer
    redirect_to rooms_path unless @customer = current_customer
  end
end
