class CreatePedidos < ActiveRecord::Migration[7.0]
  def change
    create_table :pedidos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.float :valor_total
      t.datetime :data
      t.text :endereco_completo

      t.timestamps
    end
  end
end
