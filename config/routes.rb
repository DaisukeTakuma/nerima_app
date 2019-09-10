Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'categories/index/:category_name', to: 'categories#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'sessions/new'
  get 'sessions/show'
  get 'sessions/show_comments', to: 'sessions#show_comments'



  namespace :admin do
    resources :users do
      member do
        get :show_comments
        get :following, :followers
      end
    end
  end

  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  resources :relationships,       only: [:create, :destroy]
  
  root to: 'posts#index'
  resources :posts
end