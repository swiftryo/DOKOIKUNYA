Rails.application.routes.draw do
  devise_for :users
  root 'products#top'
  get 'about' => 'products#about', as: 'products_about'
  post 'products/guest_sign_in', to: 'products#new_guest'

  patch "users/usubscribe" => "users#usubscribe", as: 'users_usubscribe'
  get "users/withdraw" => "users#withdraw", as: 'users_withdraw'
  resources :products do
    resources :reviews, only: [:index, :create]
    resource :favorites, only: [:create, :destroy, :show]
    get "index_favorites" => "favorites#index"
  end
  resources :users

  resources :genres, only: [:index, :create, :edit, :update]
  get "search" => "users#search"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
