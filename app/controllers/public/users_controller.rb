class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit] #ゲストユーザーはプロフィール編集画面に遷移できない。


  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('id DESC').limit(3) #新しい順に3つ
    @comments = @user.post_comments.order('id DESC').limit(3)
    like = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.where(id: like).order('id DESC').limit(3)
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
    @user = User.find(params[:id])
    #Likeモデルのuser_idは上記で取得したユーザーのid＋Likeモデルに格納されたpost_idも持ってくる
    #likeの中身はあるユーザー(user_id)がいいねした投稿(post_id)
    #これを変える like = Like.where(user_id: @user.id).pluck(:post_id)
    #上記の投稿を引数としてPostモデルから紐づく複数のレコードを取得
    #これを変える @like_posts = Post.where(id: like).page(params[:page]).per(10).order(created_at: :desc)
    @like_posts = @user.like_posts.page(params[:page]).per(10).order(created_at: :desc)
  end


  def bookmarks
    @user = User.find(params[:id])
    #Bookmarkモデルのuser_idは上記で取得したユーザーのid＋Bookmarkモデルに格納されpost_idも持ってくる
    #bookmarkの中身はあるユーザー(user_id)がブックマークした投稿(post_id)
    #これを変える bookmark = Bookmark.where(user_id: @user.id).pluck(:post_id)
    #上記の投稿を引数としてPostモデルから紐づく複数のレコードを取得
    #これを変える @bookmark_posts = Post.where(id: bookmark).page(params[:page]).per(10).order(created_at: :desc)
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
