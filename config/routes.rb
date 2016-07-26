Rails.application.routes.draw do


  root 'home#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' } 
  #controllers: { sessions: 'devise/sessions' }
  
  resources :books, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
  
  resources :categories, only: [:show]
  
  resources :orders, only: [:show, :edit, :update] do
    post :add_book, on: :collection
  end
  
  resources :order_books, only: [:destroy]
  resources :checkout, only: [:index, :show, :update]
  
  get '/cart', to: 'orders#edit', as: :cart
  patch '/cart/empty', to: 'orders#empty_cart', as: :empty_cart
  
  resource :user do
    patch 'update_password'
  end
end
