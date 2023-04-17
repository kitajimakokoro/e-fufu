class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
      flash[:notice] = "会員ステータスを変更しました"
      redirect_to admin_user_path(@user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :age, :gender, :status, :introduction, :profile_image, :is_deleted)
  end
end
