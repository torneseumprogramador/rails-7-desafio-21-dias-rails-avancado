require 'mysql2'
require 'yaml'

module Repositorios
  class ClientesRepositorio
    def initialize

      database_config = YAML.safe_load(File.read("#{Rails.root}/config/database.yml"), aliases: true)
      database_config = database_config[Rails.env] # Escolha o ambiente apropriado aqui

      @client = Mysql2::Client.new(
        host: database_config['host'],
        username: database_config['username'],
        password: database_config['password'],
        database: database_config['database']
      )
    end

    def salvar!(cliente)
      Servicos::ClienteValidar.new(cliente).validar!

      if cliente.id.nil?
        insert_cliente(cliente)
      else
        update_cliente(cliente)
      end
    end

    def todos(pagina = 1)
      pagina = pagina.to_i
      pagina = 1 if pagina < 1

      limit = 3
      offset = (pagina-1) * limit
      
      query = "SELECT * FROM clientes limit #{limit} offset #{offset}"
      result = @client.query(query)

      clientes = []
      result.each do |row|
        cliente = Entidades::Cliente.new
        cliente.id = row['id']
        cliente.nome = row['nome']
        cliente.telefone = row['telefone']
        cliente.endereco = row['endereco']
        clientes << cliente
      end

      clientes
    end

    private

    def insert_cliente(cliente)
      query = "INSERT INTO clientes (nome, telefone, endereco, created_at, updated_at) VALUES (?, ?, ?, now(), now())"
      statement = @client.prepare(query)
      statement.execute(cliente.nome, cliente.telefone, cliente.endereco)
    end
    
    def update_cliente(cliente)
      query = "UPDATE clientes SET nome = ?, telefone = ?, endereco = ? WHERE id = ?"
      statement = @client.prepare(query)
      statement.execute(cliente.nome, cliente.telefone, cliente.endereco, cliente.id)
    end
  end
end
