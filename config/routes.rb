Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :authors
  get 'landing/index'
  
  root 'landing#index'
end
