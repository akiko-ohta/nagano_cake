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
  resource :customers, only: [:edit, :update]
  get "customers/my_page" => "customers#show", as: "customers/show"
  get "customers/confirm_withdraw" => "customers#confirm_withdraw"
  patch "customers/withdraw" => "customers#withdraw"
  delete "cart_items/dastroy_all" => "cart_items#destroy_all"
  resources :cart_items, only: [:create, :index, :update]
  post "orders/confirm" => "orders#confirm"
  get "orders/complete" => "orders#complete"
  resources :orders, only: [:new, :create, :index, :show]
  resources :addresses
  get '/about' => "homes#about", as: "homes/about"
end

  namespace :admin do
    get "/" => "homes#top", as: "homes/top"
    resources :items, only: [:new, :create, :edit, :update, :index, :show]
    resources :customers, only: [:index, :show, :edit ,:update]
    resources :orders, only: [:show]
    resources :genres, only: [:new, :create, :edit, :update, :index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end