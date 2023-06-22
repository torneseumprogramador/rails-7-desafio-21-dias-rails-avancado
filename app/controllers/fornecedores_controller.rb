class FornecedoresController < ApplicationLoginController
# class FornecedoresController < ApplicationSeguroController # caso queria usar uma abstração de controller isolado
  
  #### para desabilitar para todas as ações json somente
  skip_before_action :verify_authenticity_token, if: :json_request?

  #### para desabilitar para todas as ações json somente, sem usar a função protegida no final deste controller
  # skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  #### para desabilitar para todas as ações cadastrar (html/json)
  # skip_before_action :verify_authenticity_token, only: [:cadastrar]

  before_action :carregar_fornecedor, only: [:novo, :mostrar, :editar, :alterar, :excluir]

  def index
    @fornecedores = Fornecedor.all
    @fornecedores = @fornecedores.limit(3).order(id: "desc")
    # render json: @fornecedores.to_json if request.format.json?
    # render json: @fornecedores.to_xml if request.format.xml?
  end

  def novo;end
  def mostrar;end
  def editar;end

  def cadastrar
    @fornecedor = Fornecedor.new(parametros_de_fornecedor)

    #### Forma 1 #####
    # if request.format.html?
    #   if @fornecedor.save
    #     flash[:notice] = "Cadastrado com sucesso"
    #     redirect_to fornecedores_path
    #   else
    #     flash[:error] = "Erro ao cadastrar - #{@fornecedor.errors.full_messages.join('<br>').html_safe}"
    #     redirect_to fornecedor_novo_path
    #   end
    #   return
    # end
    # render "mostrar" 

    #### Forma 2 #####
    respond_to do |format|
      if @fornecedor.save
        format.html { redirect_to fornecedores_path, notice: "Cadastrado com sucesso" }
        format.json { render :mostrar, status: :created, location: fornecedor_mostrar_url(@fornecedor) }
      else
        format.html do 
          flash[:error] = "Erro ao cadastrar - #{@fornecedor.errors.full_messages.join('<br>').html_safe}"
          redirect_to fornecedor_novo_path
        end
        format.json { render json: @fornecedor.errors, status: :unprocessable_entity }
      end
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
    # if @fornecedor.update(parametros_de_fornecedor)
    #   flash[:notice] = "Alteração executada com sucesso"
    #   redirect_to fornecedores_path
    # else
    #   flash[:error] = "Erro ao alterar - #{@fornecedor.errors.full_messages.join('<br>').html_safe}"
    #   redirect_to fornecedor_editar_path(@fornecedor)
    # end

    respond_to do |format|
      if @fornecedor.update(parametros_de_fornecedor)
        format.html { redirect_to fornecedores_path, notice: "Alteração executada com sucesso" }
        format.json { render :mostrar, status: 200, location: fornecedor_mostrar_url(@fornecedor) }
      else
        format.html do 
          flash[:error] = "Erro ao cadastrar - #{@fornecedor.errors.full_messages.join('<br>').html_safe}"
          redirect_to fornecedor_editar_path(@fornecedor)
        end
        format.json { render json: @fornecedor.errors, status: :unprocessable_entity }
      end
    end
  end

  def excluir
    begin
      @fornecedor.destroy!
      head :no_content
    rescue Exception => erro
      render json: { erro: erro.message }, status: 400
    end

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


  protected

  def json_request?
    request.format.json?
  end
end
