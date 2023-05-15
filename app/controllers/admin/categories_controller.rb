class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!


  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      flash[:alert] = "カテゴリ名を入力してください。なお、既にあるカテゴリ名は入力できません。"
      redirect_to admin_categories_path
    end

  end


private

  def category_params
    params.require(:category).permit(:name)
  end

end
