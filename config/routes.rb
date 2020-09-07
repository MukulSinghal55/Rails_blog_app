Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web=>"/sidekiq"
  devise_for :users
  resources :blogs
  resources :users ,only: %w[show index destroy]
  post '/comment', to: 'blogs#create_comment'
  post '/delete_comment/:id', to: 'blogs#delete_comment'
  root to: 'blogs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
