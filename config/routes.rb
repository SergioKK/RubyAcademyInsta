Rails.application.routes.draw do
  root "posts#index"

  resources :posts
  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  get 'user_posts/:user_id' => 'user/users#user_posts', as: :user_posts
  get 'user_profile/:user_id' => 'user/users#user_profile', as: :user_profile

  get ':user_id/follow_user', to: 'follows#follow', as: :follow_user
  get ':user_id/unfollow_user', to: 'follows#unfollow', as: :unfollow_user
end
