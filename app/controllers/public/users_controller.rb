class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit] #ゲストユーザーはプロフィール編集画面に遷移できない。


  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('id DESC').limit(3) #新しい順に3つ
    @comments = @user.post_comments.order('id DESC').limit(3)
    @like_posts = @user.like_posts.order('id DESC').limit(3)
  end


  def posts
    #@userでユーザーを１件取得、1行目で取得した@userのpostsで投稿を取得
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end


  def comments
    @user = User.find(params[:id])
    @comments = @user.post_comments.page(params[:page]).per(10).order(created_at: :desc)
  end


  def likes
    #@like_postsの中身は、@user＝Userモデルから取得したユーザーが、like_posts＝いいねした投稿
    @user = User.find(params[:id])
    @like_posts = @user.like_posts.page(params[:page]).per(10).order(created_at: :desc)
  end


  def bookmarks
    #@bookmark_postsの中身は、@user＝Userモデルから取得したユーザーが、bookmark_posts＝ブックマークした投稿
    @user = User.find(params[:id])
    @bookmark_posts = @user.bookmark_posts.page(params[:page]).per(10).order(created_at: :desc)
    if @user == current_user
       render "bookmarks"
    else
       redirect_to user_path(current_user)
    end
  end


  def edit
    @user = User.find(params[:id])
      if @user == current_user
        render "edit"
      else
        flash[:alert] = "他のユーザーのプロフィールは編集できません。"
        redirect_to user_path(current_user)
      end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィール編集が完了しました。"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "入力内容を再度ご確認ください。"
      render :edit
    end
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



  private

  def user_params
    params.require(:user).permit(:name, :email, :age, :gender, :status, :introduction, :profile_image, :is_deleted)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィールを編集できません。'
    end
  end


end
