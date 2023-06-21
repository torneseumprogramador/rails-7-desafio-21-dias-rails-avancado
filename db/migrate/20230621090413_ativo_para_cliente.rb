class AtivoParaCliente < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :ativo, :boolean, default: true
  end
end
