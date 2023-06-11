Rails.application.routes.draw do
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'stimulus', to: 'spa#index'
  root "home#index"

  get 'fornecedores', to: 'fornecedores#index', as: 'fornecedores'
  get 'fornecedores/novo', to: 'fornecedores#novo', as: 'fornecedores_novo'
end
