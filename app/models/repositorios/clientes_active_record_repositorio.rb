require 'mysql2'
require 'yaml'

module Repositorios
  class ClientesActiveRecordRepositorio
    def initialize(cliente)
      @cliente = cliente
    end

    def salvar(cliente)
      cliente.save
    end

    def busca_por_id(id)
      @cliente.find(2)
    end

    def todos(pagina = 1)
      pagina = pagina.to_i
      pagina = 1 if pagina < 1

      limit = 3
      offset = (pagina-1) * limit
      
      @cliente.order(id: :desc).limit(limit).offset(offset)
    end
  end
end
