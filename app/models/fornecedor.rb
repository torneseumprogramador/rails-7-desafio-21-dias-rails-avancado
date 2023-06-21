class Fornecedor < ApplicationRecord
    include BuscaPorId
    validates :nome, presence: true
end
