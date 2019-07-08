# frozen_string_literal: true

Rails.application.routes.draw do
  resources :articles
  root 'pages#index'
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'users/addfriend', to: 'users#addfriend'
  get 'users/friends', to: 'users#show_friends'
end
