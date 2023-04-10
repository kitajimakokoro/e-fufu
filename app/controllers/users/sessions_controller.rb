class Users::SessionsController < Devise::SessionsController

  #ゲストログイン用
  def guest_sign_in
    user = User.guest
    #sign_in userでゲストユーザーをログイン状態にする
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーでログインしました。'
  end

  def guest_user
    current_user == User.find_by(email: 'guest@example.com')
  end

end