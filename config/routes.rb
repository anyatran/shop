Rails.application.routes.draw do
  resources :products
  resources :carts
  resources :history
  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
