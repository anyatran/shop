Rails.application.routes.draw do
  # get 'cart_items/create'
  #
  # get 'cart_items/update'
  #
  # get 'cart_items/destroy'

  resources :products, only: [:index]
  resources :cart, only: [:show]
  resources :history, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  # get 'welcome/index'
  root to: 'products#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
