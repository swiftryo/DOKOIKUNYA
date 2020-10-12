Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/create'
  get 'reviews/destroy'
  get 'products/index'
  get 'products/show'
  get 'products/about'
  get 'products/top'
  get 'products/new'
  get 'products/create'
  get 'products/edit'
  get 'products/update'
  get 'products/destroy'
  get 'users/index'
  get 'users/edit'
  get 'users/update'
  get 'users/show'
  get 'users/withdraw'
  get 'users/unsubscribe'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
