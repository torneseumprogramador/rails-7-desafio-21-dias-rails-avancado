# json.id fornecedor.id
# json.nome fornecedor.nome
# json.razao_social fornecedor.razao_social
# json.endereco fornecedor.endereco
# json.url fornecedor_mostrar_url(fornecedor, format: :json)

json.extract! fornecedor, :id, :nome, :razao_social, :endereco, :created_at, :updated_at
json.url fornecedor_mostrar_url(fornecedor, format: :json)
