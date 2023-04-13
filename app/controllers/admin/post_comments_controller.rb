class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = PostComment.all
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
