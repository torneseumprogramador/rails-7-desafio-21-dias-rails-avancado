Rails.application.routes.draw do
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'stimulus', to: 'spa#index'
  root "home#index"


  get 'fornecedores/novo', to: 'fornecedores#novo', as: 'fornecedor_novo'
  get 'fornecedores/:id/editar', to: 'fornecedores#editar', as: 'fornecedor_editar'
  #### Padrão RESTful ###
  get 'fornecedores', to: 'fornecedores#index', as: 'fornecedores'
  get 'fornecedores/:id', to: 'fornecedores#mostrar', as: 'fornecedor_mostrar'
  post 'fornecedores', to: 'fornecedores#cadastrar', as: 'fornecedor_cadastrar'
  put 'fornecedores/:id', to: 'fornecedores#alterar', as: 'fornecedor_alterar'
  delete 'fornecedores/:id', to: 'fornecedores#excluir', as: 'fornecedor_excluir'
  #######################
end
