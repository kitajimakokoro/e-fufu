class Admin::PostCommentsController < ApplicationController

  before_action :authenticate_admin!

  def index
    #もしuseridを取得したら取得したユーザーのコメント一覧を表示
    if params[:user_id]
      @user = User.find(params[:user_id])
      @comments = @user.post_comments.page(params[:page]).per(10).order(created_at: :desc)
    #取得しなければ全コメントを表示
    else
      @comments = PostComment.page(params[:page]).per(10).order(created_at: :desc)
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to admin_post_comments_path
  end

end
