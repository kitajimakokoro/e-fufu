class Public::BookmarksController < ApplicationController

  before_action :authenticate_user!

  def create
    #まずPostモデルから投稿データを１件取得
    @post = Post.find(params[:post_id])
    #post_idカラムに上記で取得したpost.idを渡し、user_idには現在ログイン中のユーザーのidを指定
    bookmark = Bookmark.new(post_id: @post.id, user_id: current_user.id)
    #ブックマークする
    bookmark.save
  end

  def destroy
    #まずPostモデルから投稿データを１件取得
    @post = Post.find(params[:post_id])
    #post_idカラムには上記で取得したpost.idを渡し、user_idには現在ログイン中のユーザーのidを指定
    bookmark = Bookmark.find_by(post_id: @post.id, user_id: current_user.id)
    #ブックマークを外す
    bookmark.destroy
  end

end
