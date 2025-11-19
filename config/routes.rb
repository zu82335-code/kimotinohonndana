Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :tweets do   
    resources :likes, only: [:create, :destroy]
  end

  get 'tweets/search', to: 'tweets#search'

  root 'tweets#index'

  get 'posts/random', to: 'posts#random'

end
