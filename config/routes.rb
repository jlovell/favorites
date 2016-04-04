Rails.application.routes.draw do
  devise_for :users
  root to: "restaurants#index"

  resources :restaurants
  resources :dishes
end
