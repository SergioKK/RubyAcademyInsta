Rails.application.routes.draw do
  root "posts#index"

  resources :posts
  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  get 'user_posts/:user_id' => 'user/users#user_posts', as: :user_posts
  get 'profile' => 'user/users#profile', as: :user_profile
  get 'feed' => 'user/users#feed', as: :user_feed

  get 'follow_user', to: 'follows#follow', as: :follow_user
  get 'unfollow_user', to: 'follows#unfollow', as: :unfollow_user
end
