Rails.application.routes.draw do
  root to: "restaurants#index"

  resources :restaurants
  resources :dishes
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/google_oauth2', as: 'google_sign_in'
  get 'auth/failure', to: 'sessions#failure'
  get 'signout', to: 'sessions#destroy', as: 'sign_out'

  resources :sessions, only: [:create, :destroy] do
    get :failure, on: :collection
  end

  post 'addresses/fetch', to: 'addresses#fetch', as: 'fetch_address'
end
