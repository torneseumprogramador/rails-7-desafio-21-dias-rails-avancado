# Apostila de Comandos Utilizados

Aqui estão os comandos utilizados durante a conversa:

1. Criar um novo registro:

```ruby
cliente = Cliente.new(nome: "João", telefone: "123456789", endereco: "Rua A, 123")
cliente.save
```

2. Criar um novo registro em uma única linha:

```ruby
Cliente.create(nome: "Maria", telefone: "987654321", endereco: "Rua B, 456")
```

3. Ler registros (consultar):

```ruby
clientes = Cliente.all
clientes.each do |cliente|
  puts cliente.nome
end
```

4. Ler um registro específico por ID:

```ruby
cliente = Cliente.find(1)
puts cliente.nome
```

5. Atualizar um registro existente:

```ruby
cliente = Cliente.find(1)
cliente.nome = "Novo nome"
cliente.save
```

ou

```ruby
cliente = Cliente.find(1)
cliente.update(nome: "Novo nome")
```

6. Excluir um registro:

```ruby
cliente = Cliente.find(1)
cliente.destroy
```

7. Configurar um relacionamento `has_many` com exclusão em cascata:

No modelo Cliente:

```ruby
has_many :pedidos, dependent: :destroy
```

8. Criação de um cliente com produtos e pedidos utilizando uma transação:

```ruby
Cliente.transaction do
  begin
    # Criação do cliente
    cliente = Cliente.create!(nome: "João", telefone: "123456789", endereco: "Rua A, 123")

    # Criação dos produtos
    produto1 = Produto.create!(nome: "Produto 1", descricao: "Descrição do Produto 1", valor: 9.99, quantidade_estoque: 10)
    produto2 = Produto.create!(nome: "Produto 2", descricao: "Descrição do Produto 2", valor: 19.99, quantidade_estoque: 5)

    # Criação do pedido
    pedido = Pedido.new(cliente: cliente, valor_total: 29.98, data: DateTime.now, endereco_completo: "Endereço do Pedido")
    pedido.save!

    # Associação de produtos ao pedido
    pedido.produtos << produto1
    pedido.produtos << produto2

    # Atualização da quantidade de estoque dos produtos
    produto1.update!(quantidade_estoque: produto1.quantidade_estoque - 1)
    produto2.update!(quantidade_estoque: produto2.quantidade_estoque - 1)

    # Commit da transação
    Cliente.transaction do
      pedido.save!
    end
  rescue StandardError => e
    # Rollback da transação em caso de erro
    raise ActiveRecord::Rollback, e.message
  end
end
```
