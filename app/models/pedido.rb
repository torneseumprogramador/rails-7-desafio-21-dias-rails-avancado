class Pedido < ApplicationRecord
  belongs_to :cliente
  has_many :pedido_produtos, dependent: :destroy
  validates :valor_total, numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 10000 }
  validates :data, format: { with: /\d{4}-\d{2}-\d{2}/, message: "deve estar no formato YYYY-MM-DD" }
end
