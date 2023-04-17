class Public::LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    #非同期通信用のインスタンス変数を定義
    @post = Post.find(params[:post_id])
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁post_idカラムに➀で取得したpostのidを渡しこれをパラメーターとして取得
    like = Like.new(post_id: post.id)
    #➂いいねのuser.idには現在ログイン中のユーザーのuser.idを指定
    like.user_id = current_user.id
    like.save
  end

  def destroy
    #非同期通信用のインスタンス変数を定義
    @post = Post.find(params[:post_id])
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁post_idカラムにはcreateで格納されたpost.idのデータ、user_idには現在ログイン中のユーザーのidを指定
    like = Like.find_by(post_id: post.id, user_id: current_user.id)
    #➂いいねを外す
    like.destroy
  end

end
