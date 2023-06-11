class RazaoSocialEmpresa < ActiveRecord::Migration[7.0]
  def change
    add_column :fornecedores, :razao_social, :string, limit: 150
  end
end
