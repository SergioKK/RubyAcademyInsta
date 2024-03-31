Rails.application.routes.draw do
  root "posts#index"

  resources :posts
  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  get 'user_posts/:user_id' => 'user/users#show', as: :user_posts

  get 'follows/follow', as: :follow_user
  get 'follows/unfollow', as: :unfollow_user
end
