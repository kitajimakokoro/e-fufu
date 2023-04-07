Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  #URLにadminを入れる
  namespace :admin do
    root to: 'homes#top'
  end

  #publicをURLから抜く
  scope module: :public do
    root to: "homes#top"

    resources :users, only:[:show, :edit, :update] do
      member do #ユーザーidが含まれた指定のURLを生成(/user/:id/posts)
        get 'posts'
        get 'comments'
        get 'likes'
        get 'bookmarks'
      end
      collection do #ユーザーidなしで指定のURLを生成(/user/unsubscribe)
        get 'unsubscribe' =>'users#unsubscribe'
        patch 'withdraw' => 'users#withdraw'
      end
    end

    resources :posts, only:[:new, :create, :index, :show, :destroy]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
