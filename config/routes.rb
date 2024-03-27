Rails.application.routes.draw do
  root "posts#index"

  resources :posts
  resources :comments

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  get 'user_posts/:user_id' => 'posts#user', as: :user_posts
end
