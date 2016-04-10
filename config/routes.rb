Rails.application.routes.draw do
  root to: "restaurants#index"

  resources :restaurants
  resources :dishes
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/google_oauth2', as: 'google_sign_in'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'sign_out'

  resources :sessions, only: [:create, :destroy]
end
