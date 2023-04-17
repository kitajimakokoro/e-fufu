class Public::BookmarksController < ApplicationController

  before_action :authenticate_user!

  def create
    #非同期通信用のインスタンス変数を定義
    @post = Post.find(params[:post_id])
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁post_idカラムに➀で取得したpostのidを渡しこれをパラメーターとして取得
    bookmark = Bookmark.new(post_id: post.id)
    #➂ブックマークのuser.idには現在ログイン中のユーザーのuser.idを指定
    bookmark.user_id = current_user.id
    bookmark.save
  end

  def destroy
    #非同期通信用のインスタンス変数を定義
    @post = Post.find(params[:post_id])
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁post_idカラムにはcreateで格納されたpost.idのデータ、user_idには現在ログイン中のユーザーのidを指定
    bookmark = Bookmark.find_by(post_id: post.id, user_id: current_user.id)
    #➂ブックマークを外す
    bookmark.destroy
  end

end
