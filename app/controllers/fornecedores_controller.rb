class FornecedoresController < ApplicationController
  before_action :carregar_fornecedor, only: [:novo, :mostrar, :editar, :alterar, :excluir]

  def index
    @fornecedores = Fornecedor.all
    @fornecedores = @fornecedores.limit(3).order(id: "desc")
  end

  def novo;end
  def mostrar;end
  def editar;end

  def cadastrar
    fornecedor = Fornecedor.new(parametros_de_fornecedor)
    if fornecedor.save
      flash[:notice] = "Cadastrado com sucesso"
      redirect_to fornecedores_path
    else
      flash[:error] = "Erro ao cadastrar - #{fornecedor.errors.full_messages.join('<br>').html_safe}"
      redirect_to fornecedor_novo_path
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
  #     redirect_to fornecedor_novo_path
  #   end
  # end



  def alterar
    if @fornecedor.update(parametros_de_fornecedor)
      flash[:notice] = "Alteração executada com sucesso"
      redirect_to fornecedores_path
    else
      flash[:error] = "Erro ao alterar - #{@fornecedor.errors.full_messages.join('<br>').html_safe}"
      redirect_to fornecedor_editar_path(@fornecedor)
    end
  end

  def excluir
    @fornecedor.destroy
    flash[:notice] = "Exclusão executada com sucesso"
  end

  private

  def carregar_fornecedor
    if params[:id].present?
      @fornecedor = Fornecedor.find(params[:id])
    else
      @fornecedor = Fornecedor.new
    end
  end

  def parametros_de_fornecedor
    params.require(:fornecedor).permit(:nome, :cnpj, :endereco, :razao_social)
  end
end
