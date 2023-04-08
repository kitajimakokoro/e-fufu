class Public::PostCommentsController < ApplicationController

  def create
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁Postcommentモデルに紐づくデータとして投稿コメントをcommentに格納
    comment = PostComment.new(post_comment_params)
    #➂投稿コメントのuser.idには現在ログイン中のユーザーのuser.idを指定
    comment.user_id = current_user.id
    #➃投稿コメントのpost.idには➀で取得した投稿データのidを指定
    comment.post_id = post.id
    if comment.save
    #元のページにリダイレクト
      redirect_to request.referer
    else
      redirect_to request.referer
    end

  end

  def destroy
    post = PostComment.find(params[:id])
    post.destroy
    redirect_to request.referer
  end

    private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
