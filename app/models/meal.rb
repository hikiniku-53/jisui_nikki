class Meal < ApplicationRecord

  belongs_to :customer
  belongs_to :food, optional: true
  belongs_to :recipe, optional: true

  enum time: { breakfast: 0, lunch: 1, dinner: 2, others: 3 }

  def subtotal_energy
    energy * amount
  end

  def subtotal_protein
    protein * amount
  end

  def subtotal_fat
    fat * amount
  end

  def subtotal_carb
    carb * amount
  end

  def subtotal_salt_equivalent
    salt_equivalent * amount
  end

  def subtotal_price
    price * amount
  end

end
