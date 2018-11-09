Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :authors
  get 'landing/index'
  
  root 'landing#index'

  get 'polynomials/new', to: 'polynomials#new'
  get 'polynomials/:id', to: 'polynomials#show'
  
  post 'polynomials', to: 'polynomials#create'

end
