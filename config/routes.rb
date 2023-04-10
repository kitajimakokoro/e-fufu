Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  #ゲストユーザーログイン用
  devise_scope :user do #deviseに新しいルーティングを追加したいためscopeを使用
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  #URLにadminを入れる
  namespace :admin do
    root to: 'homes#top'
    resources :categories, only: [:index, :create ]
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

    #postcomment,like,bookmarkはネストしたURLを生成しparams[:post_id]で拾えるようにする
    resources :posts, only:[:new, :create, :index, :show, :destroy] do
        resources :post_comments, only: [:create, :destroy]
        resource :likes, only: [:create, :destroy] #いいねの:idは不要なため単数形で含まない
        resource :bookmarks, only: [:create, :destroy] #ブックマークの:idは不要なため単数形で含まない
      collection do
        get 'search'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
