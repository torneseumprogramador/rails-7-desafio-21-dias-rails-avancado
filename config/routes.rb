Rails.application.routes.draw do
  devise_for :useres
  resources :pedido_produtos
  resources :pedidos
  resources :produtos
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'stimulus', to: 'spa#stimulus'
  get 'jquery', to: 'spa#jquery'

  ## desabilitado para usar o devise
  # get 'login', to: 'login#index'
  # post 'acao-login', to: 'login#acao_login'
  # get 'sair', to: 'login#sair'
  
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
