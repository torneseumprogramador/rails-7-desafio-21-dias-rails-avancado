class Nota
    include Mongoid::Document
    field :nota, type: Float
    field :data, type: DateTime
    belongs_to :aluno
end
  