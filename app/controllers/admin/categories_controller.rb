class Admin::CategoriesController < ApplicationController
   before_action :authenticate_admin!

  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      @categories = Category.all
      redirect_to admin_categories_path
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      redirect_to edit_admin_category_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end
end
