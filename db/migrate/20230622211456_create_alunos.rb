class CreateAlunos < ActiveRecord::Migration[7.0]
  def change
    create_table :alunos do |t|
      t.string :nome
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
