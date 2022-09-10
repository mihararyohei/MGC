Rails.application.routes.draw do
devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
    root to: "homes#top"
    resources :bookmarks, only: [:show,:update]
    resources :customers, only: [:show,:index,:edit,:update]
    resources :communities, only: [:index,:create,:edit,:update]
    resources :chats, except: [:destroy]
  end

  scope module: :public do
    root to: "homes#top"

    resources :comments, only: [:index,:edit,:create,:update,:destroy]

    post 'bookmarks/confirm'
    resources :bookmarks, only: [:new]

    resources :chats, only: [:index,:update,:destroy,:create]

    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    resources :customers, only: [:show,:edit,:update]

    resources :communities, only: [:index,:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
