class Meal < ApplicationRecord
  belongs_to :customer

  validates :amount, presence: true

  enum time: { breakfast: 0, lunch: 1, dinner: 2, others: 3 }

  def subtotal_energy
    if is_food
      energy * amount / 100
    else
      energy * amount
    end
  end

  def subtotal_protein
    if is_food
      protein * amount / 100
    else
      protein * amount
    end
  end

  def subtotal_fat
    if is_food
      fat * amount / 100
    else
      fat * amount
    end
  end

  def subtotal_carb
    if is_food
      carb * amount / 100
    else
      carb * amount
    end
  end

  def subtotal_salt_equivalent
    if is_food
      salt_equivalent * amount / 100
    else
      salt_equivalent * amount
    end
  end

  def subtotal_price
    if is_food
      price * amount / 100
    else
      price * amount
    end
  end
end
