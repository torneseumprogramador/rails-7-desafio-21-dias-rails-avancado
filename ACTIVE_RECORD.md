# Apostila de Comandos Utilizados

Aqui estão os comandos utilizados durante a conversa:

## Comandos de Active Record

### Criação, Leitura, Atualização e Exclusão (CRUD)

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

### Associações e Relacionamentos

7. Configurar um relacionamento `has_many` com exclusão em cascata:

No modelo Cliente:

```ruby
has_many :pedidos, dependent: :destroy
```

8. Consulta básica com JOIN:

```ruby
Pedidos.joins(:cliente).limit(3).each do |pedido|
  puts pedido.cliente.nome
end
```

9. Consulta com JOIN e condição de filtro:

```ruby
Pedidos.joins(:cliente).where(clientes: { nome: "João" }).each do |pedido|
  puts pedido.cliente.nome
end
```

10. Consulta com JOIN e ordenação:

```ruby
Pedidos.joins(:cliente).order("clientes.nome").each do |pedido|
  puts pedido.cliente.nome
end
```

11. Consulta com JOIN, filtro e ordenação:

```ruby
Pedidos.joins(:cliente).where(clientes: { nome: "João" }).order("clientes.nome").each do |pedido|
  puts pedido.cliente.nome
end
```

12. Uso do método `includes` para evitar o problema de N + 1:

```ruby
Pedido.includes(:cliente).limit(3).each do |pedido|
  puts pedido.cliente.nome
end
```

13. Uso do método `select` com `includes` para selecionar colunas específicas:

```ruby
Pedido.includes(:cliente).select('pedidos.*, clientes.*').limit(3).each do |pedido|
  puts pedido.cliente.nome
end
```

14. Uso da gem Bullet para detectar queries N + 1:

E utilize os seguintes comandos:

```ruby

Pedido.includes(:cliente, pedido_produtos: [:produto])

Pedido.eager_load(:cliente).limit(3)

````


```ruby
Pedido.eager_load(:cliente).limit(3).each do |pedido|
  puts pedido.cliente.nome
end
```


15. Consulta bruta com SQL:

```ruby
results = ActiveRecord::Base.connection.exec_query("
    SELECT 
        pedidos.id AS pedido_id, 
        clientes.nome AS cliente_nome
    FROM pedidos 
        LEFT OUTER JOIN clientes ON clientes.id = pedidos.cliente_id 
    LIMIT 3
")

results.each do |row|
  puts row['cliente_nome']
end
```


## Comandos de Active Record (Continuação)

### Consultas Avançadas e Otimizações

15. Uso do método `eager_load` para carregar dados associados:

```ruby
Pedido.eager_load(:cliente).limit(3)
```

16. Uso do método `eager_load` com `each` para acessar dados associados:

```ruby
Pedido.eager_load(:cliente).limit(3).each do |pedido|
  puts pedido.cliente.nome
end
```

17. Consulta bruta utilizando `exec_query`:

```ruby
results = ActiveRecord::Base.connection.exec_query("
  SELECT 
    pedidos.id AS pedido_id, 
    clientes.nome AS cliente_nome
  FROM pedidos 
    LEFT OUTER JOIN clientes ON clientes.id = pedidos.cliente_id 
  LIMIT 3
")

results.each do |row|
  puts row['cliente_nome']
end
```

18. Consultas com cláusulas SQL personalizadas:

```ruby
cliente = Cliente.where("id in (2,3)")
cliente = cliente.where("nome like '%a%'")
cliente = cliente.where("nome = 'teste'")
cliente
```

## Comandos do Rails

19. Gerar scaffold para um modelo:

```shell
rails generate scaffold Cliente nome:string telefone:string endereco:string
```

20. Executar migrações pendentes:

```shell
rails db:migrate
```

21. Exibir rotas disponíveis:

```shell
rails routes
```

22. Executar servidor Rails:

```shell
rails server
```

23. Utilizar a gem Faker para gerar dados fictícios:

Adicione a gem `faker` ao Gemfile:

```ruby
gem 'faker'
```

Execute o comando `bundle install` para instalar a gem.

24. Seed data usando a gem Faker:

Dentro do arquivo `db/seeds.rb`, adicione o seguinte código:

```ruby
require 'faker'

10.times do
  Cliente.create(
    nome: Faker::Name.name,
    telefone: Faker::PhoneNumber.phone_number,
    endereco: Faker::Address.full_address
  )
end

10.times do
  Produto.create(
    nome: Faker::Commerce.product_name,
    descricao: Faker::Lorem.sentence,
    valor: Faker::Commerce.price(range: 10..100),
    quantidade_estoque: Faker::Number.between(from: 0, to: 100)
  )
end

10.times do
  cliente = Cliente.order("RANDOM()").first
  pedido = Pedido.create(
    cliente_id: cliente.id,
    valor_total: Faker::Commerce.price(range: 50..500),
    data: Faker::Date.between(from: 1.year.ago, to: Date.today),
    endereco_completo: Faker::Address.full_address
  )

  3.times do
    produto = Produto.order("RANDOM()").first
    PedidoProduto.create(
      pedido_id: pedido.id,
      produto_id: produto.id,
      valor: produto.valor,
      quantidade: Faker::Number.between(from: 1, to: 5)
    )
  end
end
```

25. Gerar um diagrama de banco de dados usando a gem rails-erd:

Certifique-se de ter a gem `rails-erd` no Gemfile:

```ruby
gem 'rails-erd', group: :development
```

Execute o comando `bundle install` para instalar a gem.

Execute o comando `bundle exec erd` para gerar o diagrama de banco de dados.

Espero que esta apostila seja útil para você!
