class Public::UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
  end

  #@userでユーザーを１件取得、1行目で取得した@userのpostsで投稿を取得
  #アソシエーションをモデルに記載したからできること
  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def comments
    @user = User.find(params[:id])
    @comments = @user.post_comments
  end

  def likes
    @user = User.find(params[:id])
    #Likeモデルのuser_idは上記で取得したユーザーのid＋Likeモデルのpost_idも持ってくる
    #likeの中身はあるユーザー(user_id)がいいねした投稿(post_id)
    like = Like.where(user_id: @user.id).pluck(:post_id)
    #上記の投稿を引数としてPostモデルから投稿を取得
    @like_posts = Post.find(like)
  end

  def bookmarks
    @user = User.find(params[:id])
    #Bookmarkモデルのuser_idは上記で取得したユーザーのid＋Bookmarkモデルのpost_idも持ってくる
    #bookmarkの中身はあるユーザー(user_id)がブックマークした投稿(post_id)
    bookmark = Bookmark.where(user_id: @user.id).pluck(:post_id)
    #上記の投稿を引数としてPostモデルから投稿を取得
    @bookmark_posts = Post.find(bookmark)
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
        redirect_to user_path(current_user)
      end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
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

  def user_params
    params.require(:user).permit(:name, :email, :age, :gender, :status, :introduction, :profile_image)
  end

end
