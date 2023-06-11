class CreateFornecedores < ActiveRecord::Migration[7.0]
  def change
    create_table :fornecedores do |t|
      t.string :nome, limit: 150
      t.string :cnpj, limit: 20
      t.string :endereco, limit: 255

      t.timestamps
    end
  end
end
