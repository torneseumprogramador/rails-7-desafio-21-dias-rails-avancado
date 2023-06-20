json.extract! produto, :id, :nome, :descricao, :valor, :quantidade_estoque, :created_at, :updated_at
json.url produto_url(produto, format: :json)
