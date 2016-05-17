Rails.application.routes.draw do
  root to: "homepage#index"

  resources :users, shallow: true do
    member do
      get :following, :followers
    end
    resources :tweets do
      resources :comments
    end
  end

  resources :relationships, only: [:create, :destroy]

  patch "tweets/:id/like", to: "tweets#like", as: "like_tweet"
  patch "tweets/:id/dislike", to: "tweets#dislike", as:"dislike_tweet"

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create", as: "sessions"
  get "/logout", to: "sessions#destroy"
end
