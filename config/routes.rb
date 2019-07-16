# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'

  # API routes
  namespace :api do
    namespace :v1 do
      resources :articles
      resources :users
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end

  # Aritcles routes
  resources :articles

  # Users routes
  resources :users, except: [:new]

  # Messages routes
  resources :messages

  # Authentication routes
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Friends routes
  post 'addfriend', to: 'users#addfriend'
  get 'friends', to: 'users#show_friends'
  delete 'removefriend', to: 'users#removefriend'
end
