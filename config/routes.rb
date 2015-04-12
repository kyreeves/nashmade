Rails.application.routes.draw do
  devise_for :users
  resources :products

  get 'seller', to: 'products#seller'

  root 'products#index'

end
