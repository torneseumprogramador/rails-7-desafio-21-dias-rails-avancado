class ClienteEmail < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :email, :string
  end
end
