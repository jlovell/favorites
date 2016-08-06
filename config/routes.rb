Rails.application.routes.draw do
  root to: "restaurants#index"

  resources :restaurants
  resources :dishes
  post 'addresses/fetch', to: 'addresses#fetch', as: 'fetch_address'

  resources :sessions, only: [:new, :create, :destroy] do
    get :failure, on: :collection
  end
  get 'auth/failure', to: 'sessions#failure'
  get 'auth/google_oauth2', as: 'google_sign_in'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'sign_out'

end
