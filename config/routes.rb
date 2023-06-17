Rails.application.routes.draw do
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'stimulus', to: 'spa#stimulus'
  get 'jquery', to: 'spa#jquery'

  get 'hotwire', to: 'spa#hotwire'
  get 'hotwire_template', to: 'spa#hotwire_template', as: 'hotwire_template'

  get 'carregando-pedaco-codigo', to: 'spa#carregando_pedaco_codigo'

  
  root "home#index"


  get 'fornecedores/novo', to: 'fornecedores#novo', as: 'fornecedor_novo'
  get 'fornecedores/:id/editar', to: 'fornecedores#editar', as: 'fornecedor_editar'
  #### Padrão RESTful ###
  get 'fornecedores', to: 'fornecedores#index', as: 'fornecedores'
  get 'fornecedores/:id', to: 'fornecedores#mostrar', as: 'fornecedor_mostrar'
  post 'fornecedores', to: 'fornecedores#cadastrar', as: 'fornecedor_cadastrar'
  match 'fornecedores/:id', to: 'fornecedores#alterar', as: 'fornecedor', via: [:put, :patch]
  delete 'fornecedores/:id', to: 'fornecedores#excluir', as: 'fornecedor_excluir'
  #######################
end
