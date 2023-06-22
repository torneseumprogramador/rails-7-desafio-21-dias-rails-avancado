class Aluno < ApplicationRecord
    validates :nome, :email, :password, presence: true
    validates :email, uniqueness: true
end
