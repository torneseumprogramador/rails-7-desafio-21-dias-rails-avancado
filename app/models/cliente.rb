class Cliente < ApplicationRecord
  include BuscaPorId


  has_many :pedidos, dependent: :destroy

  # validates :nome, :telefone, presence: true
  # validates :telefone, uniqueness: true
  # validates :telefone, format: { with: /\A\(\d{2}\)\s\d{5}-\d{4}\z/, message: "deve estar no formato (00) 00000-0000" }
  # validates :nome, length: { minimum: 5, maximum: 150 }
  # validates :nome, inclusion: { in: %w(Silva Santos Felix), message: "%{value} não é um tipo de nome válido" }
  # validates :nome, inclusion: { in: ["Silva", "Santos", "Felix"], message: "%{value} não é um tipo de nome válido" }
  
  # validates :nome, exclusion: { in: %w(Matiazi Ferdinant), message: "(%{value}) de usuário não está disponível" }

  # validates :ativo, acceptance: { message: "Você precisa deixar o seu cliente ativo" }

  
  # validate :custom_validation_method



  # def custom_validation_method
  #   if !self.nome.include?("Silva") || !self.telefone.include?("(21)")
  #     self.errors.add(:telefone, "precisa conter Silva no nome e o ddd precisa ser (21)")
  #   end
  # end
end
