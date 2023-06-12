class Fornecedor < ApplicationRecord
    validates :nome, presence: true
end
