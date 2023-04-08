class Public::LikesController < ApplicationController

   def create
    #➀まずPostモデルから投稿データを１件取得
    post = Post.find(params[:post_id])
    #➁pst_idカラムに➀で取得したpostのidを渡しこれをパラメーターとして取得
    like = Like.new(post_id: post.id)
    #➂いいねのuser.idには現在ログイン中のユーザーのuser.idを指定
    like.user_id = current_user.id
    favorite.save
    redirect_to post_image_path(post_image)

    #記載途中！！！

  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    favorite.destroy
    redirect_to post_image_path(post_image)
  end

end
