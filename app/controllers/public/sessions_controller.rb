# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

 #退会しているか判断するメソッド
def user_state
  #Userモデルから入力されたemailを検索し該当アカウントを1件取得
  @user = User.find_by(email: params[:user][:email])
  # アカウントを取得できなかった場合、このメソッドを終了する
  return if !@user
    #取得したアカウントのパスワードと入力されたパスワードが一致してるか && 取得したユーザーの退会ステータスを判別
  if @user.valid_password?(params[:user][:password]) && @user.is_deleted == true
    flash[:notice] = "退会済みの為、再登録が必要です。"
    #上記どちらもtrueだった場合、サインアップ画面に遷移する
    redirect_to new_user_registration_path
  end
end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
