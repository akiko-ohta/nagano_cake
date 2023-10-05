Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
  resources :items, only: [:index, :show]
  resources :customers, only: [:edit, :update]
  get "customers/my_page" => "customers#show", as: "customers/show"
  resources :customers do
    collection do
      get "confirm_withdraw"
      patch "withdraw"
    end
  end
  resources :cart_items, only: [:index, :create, :update, :destroy]
  resources :cart_items do
    collection do
      delete "destroy_all"
    end
  end
  resources :orders, onle: [:new, :create, :index, :show]
  resources :orders do
    collection do
      post "confirm"
      get "complete"
    end
  end
  resources :addresses
  get '/about' => "homes#about", as: "homes/about"
end

  namespace :admin do
    get "/" => "homes#top", as: "homes/top"
    resources :items, only: [:new, :create, :edit, :update, :index, :show]
    resources :customers, only: [:index, :show, :edit ,:update]
    resources :orders, only: [:show]
    resources :genres, only: [:new, :create, :edit, :update, :index, :show]
    resources :genres do
      collection do
        patch "unavailable"
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
