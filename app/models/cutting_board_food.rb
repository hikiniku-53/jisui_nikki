class CuttingBoardFood < ApplicationRecord
  belongs_to :customer
  belongs_to :food

  validates :amount, presence: true

  def subtotal_energy
    food.energy * amount / 100
  end

  def subtotal_protein
    food.protein * amount / 100
  end

  def subtotal_fat
    food.fat * amount / 100
  end

  def subtotal_carb
    food.carb * amount / 100
  end

  def subtotal_salt_equivalent
    food.salt_equivalent * amount / 100
  end
end
