Rails.application.routes.draw do
  get "sessions/new"
  get "users/new"
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "users/:id/following", to: "follows#following", as: "following"
  get "users/:id/followers", to: "follows#followers", as: "followers"

  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show delete)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
end
