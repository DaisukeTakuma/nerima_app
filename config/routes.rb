Rails.application.routes.draw do
  get 'categories/index/:category_name', to: 'categories#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'sessions/new'
  get 'sessions/show'

  namespace :admin do
    resources :users
  end
  
  root to: 'posts#index'
  resources :posts
end