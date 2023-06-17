class SpaController < ApplicationController
  def stimulus;end
  def jquery;end


  def hotwire;end
  def hotwire_template
    @clientes = Cliente.all
  end

  layout 'blank', only: ['carregando_pedaco_codigo']
  def carregando_pedaco_codigo
    @clientes = Cliente.all
  end
end
