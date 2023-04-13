class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to request.referer
  end


private

  def category_params
    params.require(:category).permit(:name)
  end

end
