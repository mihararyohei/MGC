class Public::BookmarksController < ApplicationController
  before_action :ensure_correct_customer
  def index
    @communities = Community.limit(8).order(created_at: :desc)
    @communities = current_customer.communities.limit(8).order(created_at: :desc)
  end

  def show

  end

  def ensure_correct_customer
    @customer = current_customer
    redirect_to products_path unless @customer = current_customer
  end
end
