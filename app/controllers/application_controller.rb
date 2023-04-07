class ApplicationController < ActionController::Base

  #ログインしていない状態でのトップページ以外のアクセスを制限する
  before_action :authenticate_user!, except: [:top]

end
