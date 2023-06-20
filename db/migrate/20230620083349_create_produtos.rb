class CreateProdutos < ActiveRecord::Migration[7.0]
  def change
    create_table :produtos do |t|
      t.string :nome, limit: 100
      t.text :descricao
      t.float :valor
      t.integer :quantidade_estoque

      t.timestamps
    end
  end
end
