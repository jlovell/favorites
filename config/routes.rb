Rails.application.routes.draw do
  root to: "restaurants#index"

  resources :restaurants
  resources :dishes
  get '/auth/:provider/callback', to: 'sessions#create', as: :login
end
