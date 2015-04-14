Rails.application.routes.draw do
  devise_for :users
  resources :products do
    resources :orders
  end

  get 'purchases', to: 'orders#purchases'
  get 'seller', to: 'products#seller'
  get 'sales', to: 'orders#sales'


  root 'products#index'

end
