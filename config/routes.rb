Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :customers, only: [:show,:index,:edit,:update]
    resources :categories, only: [:index,:create,:edit,:update]
    delete 'rooms/:room_id/destroy_all',to: 'rooms#destroy_all',as: 'rooms_destroy_all'
    delete 'rooms/:message_id/destroy',to: 'rooms#destroy',as: 'rooms_destroy'
    resources :rooms, only: [:index,:create,:edit,:update,:show]
  end

  scope module: :public do
    root to: "homes#top"

    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    resources :customers, only: [:show,:edit,:update]

    resources :bookmarks, only: [:index,:show]

    delete 'rooms/:message_id/destroy',to: 'rooms#destroy',as: 'rooms_destroy'
    resources :rooms,only:[:index,:show]do
      resource :bookmarks, only: [:create, :destroy]
    end
    get 'searches/search'
  end

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
