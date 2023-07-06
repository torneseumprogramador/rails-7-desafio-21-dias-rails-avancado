class Aluno
    include Mongoid::Document
    field :nome, type: String
    field :matricula, type: String
    field :idade, type: Integer
    field :email, type: String
    has_many :notas
end