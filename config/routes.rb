Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Defines the root path route ("/")
  root "home#index"

  resources :posts, only: [:new, :create]

  mount ActionCable.server => "/cable"
end
