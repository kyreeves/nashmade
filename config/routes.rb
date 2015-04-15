Rails.application.routes.draw do
  devise_for :users

  resources :products do
    collection do
      get 'search'
    end
    resources :orders
  end


  get 'purchases', to: 'orders#purchases'
  get 'sales', to: 'orders#sales'
  get 'seller', to: 'products#seller'

  root 'products#index'
end
