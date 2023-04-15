class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @comments = @user.post_comments.order(created_at: :desc)
    else
      @comments = PostComment.all.order(created_at: :desc)
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to admin_post_comments_path
  end

   private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
