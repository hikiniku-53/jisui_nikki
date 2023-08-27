class Meal < ApplicationRecord

  belongs_to :customer
  belongs_to :food, optional: true
  belongs_to :recipe, optional: true

  enum time: { breakfast: 0, lunch: 1, dinner: 2, others: 3 }

  def subtotal_energy
    if self.food_id
      energy * amount / 100
    else
      energy * amount
    end
  end

  def subtotal_protein
    if self.food_id
      protein * amount / 100
    else
      protein * amount
    end
  end

  def subtotal_fat
    if self.food_id
      fat * amount / 100
    else
      fat * amount
    end
  end

  def subtotal_carb
    if self.food_id
      carb * amount / 100
    else
      carb * amount
    end
  end

  def subtotal_salt_equivalent
    if self.food_id
      salt_equivalent * amount / 100
    else
      salt_equivalent * amount
    end
  end

  def subtotal_price
    if self.food_id
      price * amount / 100
    else
      price * amount
    end
  end

end
