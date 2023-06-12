class FornecedoresController < ApplicationController
  def index
    @fornecedores = Fornecedor.all
    @fornecedores = @fornecedores.limit(4).order(id: "desc")
  end

  def novo
  end

  def cadastrar
    fornecedor = Fornecedor.new(parametros_de_fornecedor)
    if fornecedor.save
      flash[:notice] = "Cadastrado com sucesso"
      redirect_to fornecedores_path
    else
      flash[:error] = "Erro ao cadastrar - #{fornecedor.errors.full_messages.join('<br>').html_safe}"
      redirect_to fornecedores_novo_path
    end
  end

  # def cadastrar
  #   fornecedor = Fornecedor.new(parametros_de_fornecedor)
  #   begin
  #     fornecedor.save!
  #     flash[:notice] = "Cadastrado com sucesso"
  #     redirect_to fornecedores_path
  #   rescue Exception => erro
  #     flash[:error] = "Erro ao cadastrar - #{erro.message}"
  #     redirect_to fornecedores_novo_path
  #   end
  # end


  private

  def parametros_de_fornecedor
    params.require(:fornecedor).permit(:nome, :cnpj, :endereco, :razao_social)
  end
end
