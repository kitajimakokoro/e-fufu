Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}



  namespace :admin do
    root to: 'homes#top'
  end

  #publicをURLから抜く
  scope module: :public do
    root to: "homes#top"

    resources :users, only:[:show, :edit, :update] do
      #ユーザーidが含まれた指定のURLを生成(/user/:id/posts)
      member do
        get 'posts'
        get 'comments'
        get 'likes'
        get 'bookmarks'
      end
      #ユーザーidなしで指定のURLを生成(/user/unsubscribe)
      collection do
        get 'unsubscribe' =>'users#unsubscribe'
        patch 'withdraw' => 'users#withdraw'
      end
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
