
module Servicos
  class ClienteValidar
    def initialize(cliente)
      @cliente = cliente
    end

    def validar!
      raise Servicos::Erros::ValidarErros.new("o nome não pode ficar vazio") if @cliente.nome.blank?
    end
  end
end