class Public::LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    #まずPostモデルから投稿データを１件取得
    @post = Post.find(params[:post_id])
    #post_idカラムに上記で取得したpost.idを渡し、user_idには現在ログイン中のユーザーのidを指定
    like = Like.new(post_id: @post.id, user_id: current_user.id)
    #いいねする
    like.save
  end

  def destroy
    #まずPostモデルから投稿データを１件取得
    @post = Post.find(params[:post_id])
    #post_idカラムには上記で取得したpost.idを渡し、user_idには現在ログイン中のユーザーのidを指定
    like = Like.find_by(post_id: @post.id, user_id: current_user.id)
    #いいねを外す
    like.destroy
  end

end
