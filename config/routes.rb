Rails.application.routes.draw do
  devise_for :users
  root 'products#top'
  get 'about' => 'products#about', as: 'products_about'

  patch "users/usubscribe" => "users#usubscribe", as: 'users_usubscribe'
  get "users/withdraw" => "users#withdraw", as: 'users_withdraw'
  resources :products do
    resources :reviews, only: [:index, :create]
  end
  resources :users

  get "search" => "products#search", as:"users_search"
  resources :genres, only: [:index, :create, :edit, :update]


  #残りお気に入り、チャット、

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
