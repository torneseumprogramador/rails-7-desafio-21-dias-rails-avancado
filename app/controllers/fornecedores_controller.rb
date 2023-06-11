class FornecedoresController < ApplicationController
  def index
    @fornecedores = Fornecedor.all
    @fornecedores = @fornecedores.limit(4)
  end

  def novo
  end
end
