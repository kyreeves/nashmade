Rails.application.routes.draw do
  resources :products

  root 'products#index'
  devise_for :users

end
