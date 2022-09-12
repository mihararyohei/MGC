class Admin::CommunitiesController < ApplicationController
  def index
    @community = Community.new
    @communities = Community.all
  end

  def edit
    @community = Community.find(params[:id])
  end

  def create
    @community = Community.new(communities_params)
    if @community.save
       redirect_to admin_communities_path
    else
      @communities = community.all
      render admin_communities_path
    end
  end

  def update
    @community = Community.find(params[:id])
    if @community.update(communities_params)
       redirect_to admin_communities_path
    else
      render edit_admin_community_path(community.id)
    end
  end

  private

  def communities_params
    params.require(:community).permit(:community_name)
  end
end
