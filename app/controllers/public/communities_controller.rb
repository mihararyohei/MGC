class Public::CommunitiesController < ApplicationController
  def index
    @communities = Community.limit(8).order(created_at: :desc)
  end

  def show
  end
end
