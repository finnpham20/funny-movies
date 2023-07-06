# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Defines the root path route ("/")
  root 'home#index'

  resources :posts, only: %i[new create]

  mount ActionCable.server => '/cable'

  post "/", to: 'application#render_404'
  put "/", to: 'application#render_404'
  delete "/", to: 'application#render_404'
  patch "/", to: 'application#render_404'
  get "*a", to: 'application#render_404'
  post "*a", to: 'application#render_404'
  put "*a", to: 'application#render_404'
  delete "*a", to: 'application#render_404'
  patch "*a", to: 'application#render_404'
end
