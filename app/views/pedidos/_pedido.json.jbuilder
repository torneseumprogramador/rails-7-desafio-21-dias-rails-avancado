json.extract! pedido, :id, :cliente_id, :valor_total, :data, :endereco_completo, :created_at, :updated_at
json.url pedido_url(pedido, format: :json)
