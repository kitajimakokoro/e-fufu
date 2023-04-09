class Public::LikesController < ApplicationController

   def create
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁post_idカラムに➀で取得したpostのidを渡しこれをパラメーターとして取得
    like = Like.new(post_id: post.id)
    #➂いいねのuser.idには現在ログイン中のユーザーのuser.idを指定
    like.user_id = current_user.id
    like.save
    #元のページにリダイレクト
    redirect_to request.referer
  end

  def destroy
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁post_idカラムにはcreateで格納されたpost.idのデータ、user_idには現在ログイン中のユーザーのidを指定
    like = Like.find_by(post_id: post.id, user_id: current_user.id)
    #➂いいねを外す
    like.destroy
    #元のページにリダイレクト
    redirect_to request.referer
  end

end
