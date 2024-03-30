Rails.application.routes.draw do
  root "posts#index"

  get 'user_posts/:user_id' => 'user/users#show', as: :user_posts

  resources :posts
  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }
end
