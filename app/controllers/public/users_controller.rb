class Public::UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
  end

  def posts
  end

  def comments
  end

  def likes
  end

  def bookmarks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    #is_deletedカラムがtrueになった時のフラグを立てる(defaultはfalse)
    @user.update(is_deleted: true)
    #trueの場合ユーザーをログアウトさせる
    reset_session
    flash[:notice] = "退会処理が完了いたしました。"
    #ログアウト後ルートパスに遷移
    redirect_to root_path
  end
  
  def user_params
    params.require(:user).permit(:name, :age, :gender, :status, :introduction, :profile_image)
  end
  
end
