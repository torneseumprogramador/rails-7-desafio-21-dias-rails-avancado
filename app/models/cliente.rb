class Cliente < ApplicationRecord
  has_many :pedidos, dependent: :destroy
  validates :nome, presence: true
end
