class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

end
