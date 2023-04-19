class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!

  def index
    #もしuseridを取得したら取得したユーザーの投稿一覧を表示
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
    #取得しなければ全投稿を表示
    else
      @posts = Post.page(params[:page]).per(10).order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to admin_posts_path
  end

end
