class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[ show edit update destroy ]

  # GET /clientes or /clientes.json
  # def index
  #   page = params[:pagina].to_i || 1
  #   page = 1 if page < 1

  #   quantidade_por_pagina = 3

  #   offset = (page-1) * quantidade_por_pagina

  #   @clientes = Cliente.order(id: :desc).limit(quantidade_por_pagina).offset(offset)

  #   respond_to do |format|
  #     format.turbo_stream { 
  #       render turbo_stream: turbo_stream.append(:clientes, partial: 'clientes/clientes_hotwire', locals: { clientes: @clientes })
  #     }

  #     format.html { render :index }
  #   end
  # end



  def index
    repo = Repositorios::ClientesRepositorio.new

    # cliente1 = Entidades::Cliente.new
    # cliente1.nome = "Luiz"
    # cliente1.telefone = "11111111"
    # cliente1.endereco = "Rua do Luiz"

    # repo.salvar(cliente1)

    # cliente2 = Entidades::Cliente.new
    # cliente2.id = 2
    # cliente2.nome = "Luiz Santos"
    # cliente2.telefone = "11111111"
    # cliente2.endereco = "Rua do Luiz"

    # repo.salvar(cliente2)

    # cliente_erro = Entidades::Cliente.new
    # cliente_erro.telefone = "11111111"
    # cliente_erro.endereco = "Rua do Luiz"

    # begin
    #   repo.salvar!(cliente_erro)
    # rescue Servicos::Erros::ValidarErros => erro
    #   flash["error"] = "Erro na minha validação - #{erro.message}"
    #   return redirect_to "/stimulus"
    # rescue Exception => erro
    #   flash["error"] = erro.message
    #   return redirect_to "/stimulus"
    # end

    @clientes = repo.todos(params[:pagina])

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.append(:clientes, partial: 'clientes/clientes_hotwire', locals: { clientes: @clientes })
      }

      format.html { render :index }
    end
  end


  # def index
  #   repo = Repositorios::ClientesActiveRecordRepositorio.new(Cliente)

  #   # cliente1 = Cliente.new
  #   # cliente1.nome = "Luiz 4"
  #   # cliente1.telefone = "11111111"
  #   # cliente1.endereco = "Rua do Luiz"

  #   # repo.salvar(cliente1)

  #   # cliente2 = repo.busca_por_id(2)
  #   # cliente2.nome = "Luiz Santos"

  #   # repo.salvar(cliente2)

  #   @clientes = repo.todos(params[:pagina])

  #   respond_to do |format|
  #     format.turbo_stream { 
  #       render turbo_stream: turbo_stream.append(:clientes, partial: 'clientes/clientes_hotwire', locals: { clientes: @clientes })
  #     }

  #     format.html { render :index }
  #   end
  # end

  # GET /clientes/1 or /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes or /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to cliente_url(@cliente), notice: "Cliente was successfully created." }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1 or /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to cliente_url(@cliente), notice: "Cliente was successfully updated." }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to clientes_url, notice: "Cliente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params.require(:cliente).permit(:nome, :telefone, :endereco)
    end
end
