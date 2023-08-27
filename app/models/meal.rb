class Meal < ApplicationRecord

  belongs_to :customer

  enum time: { breakfast: 0, lunch: 1, dinner: 2, others: 3 }

  def subtotal_energy
    if self.is_food
      energy * amount / 100
    else
      energy * amount
    end
  end

  def subtotal_protein
    if self.is_food
      protein * amount / 100
    else
      protein * amount
    end
  end

  def subtotal_fat
    if self.is_food
      fat * amount / 100
    else
      fat * amount
    end
  end

  def subtotal_carb
    if self.is_food
      carb * amount / 100
    else
      carb * amount
    end
  end

  def subtotal_salt_equivalent
    if self.is_food
      salt_equivalent * amount / 100
    else
      salt_equivalent * amount
    end
  end

  def subtotal_price
    if self.is_food
      price * amount / 100
    else
      price * amount
    end
  end

end
