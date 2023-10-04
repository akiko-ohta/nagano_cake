Rails.application.routes.draw do
  namespace :admin do
    get 'genres/new'
    get 'genres/create'
    get 'genres/edit'
    get 'genres/update'
    get 'genres/show'
    get 'genres/index'
    get 'genres/unvailable'
  end
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
  end
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/create'
    get 'items/show'
    get 'items/edit'
    get 'items/update'
  end
  namespace :admin do
    get 'homes/top'
  end

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
  get 'homes/top'
  get '/about' => "homes#about", as: "homes/about"
end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  root to: "public/homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
