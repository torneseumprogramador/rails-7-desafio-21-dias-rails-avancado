# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



# Seed data for Clientes
10.times do
  Cliente.create(
    nome: Faker::Name.name,
    telefone: Faker::PhoneNumber.phone_number,
    endereco: Faker::Address.full_address
  )
end

# Seed data for Produtos
10.times do
  Produto.create(
    nome: Faker::Commerce.product_name,
    descricao: Faker::Lorem.sentence,
    valor: Faker::Commerce.price(range: 10..100),
    quantidade_estoque: Faker::Number.between(from: 0, to: 100)
  )
end

# Seed data for Pedidos
10.times do
  cliente = Cliente.order("RAND()").first
  pedido = Pedido.create(
    cliente_id: cliente.id,
    valor_total: Faker::Commerce.price(range: 50..500),
    data: Faker::Date.between(from: 1.year.ago, to: Date.today),
    endereco_completo: Faker::Address.full_address
  )
  
  # Seed data for PedidoProdutos
  3.times do
    produto = Produto.order("RAND()").first
    PedidoProduto.create(
      pedido_id: pedido.id,
      produto_id: produto.id,
      valor: produto.valor,
      quantidade: Faker::Number.between(from: 1, to: 5)
    )
  end
end