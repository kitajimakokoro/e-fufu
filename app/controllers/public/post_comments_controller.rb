class Public::PostCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    #まずPostモデルから投稿データを１件取得
    @post = Post.find(params[:post_id])
    #Postcommentモデルに紐づくデータとして投稿コメントをcommentに格納
    comment = PostComment.new(post_comment_params)
    #投稿コメントのuser.idには現在ログイン中のユーザーのuser.idを指定
    comment.user_id = current_user.id
    #投稿コメントのpost.idには１行目で取得した投稿データのidを指定
    comment.post_id = @post.id
    comment.save
    #非同期通信用のインスタンス変数を定義
    @post_comment = PostComment.new

  end

  def destroy
    post = PostComment.find(params[:id])
    post.destroy
    #非同期通信用のインスタンス変数を定義
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new
  end

    private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
