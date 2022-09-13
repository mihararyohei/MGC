class Public::CommunitiesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @communities = Community.limit(8).order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end
end
