Rails.application.routes.draw do
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'stimulus', to: 'spa#index'
  root "home#index"
end
