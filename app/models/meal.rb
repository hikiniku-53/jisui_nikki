class Meal < ApplicationRecord

  belongs_to :customer
  belongs_to :food, optional: true
  belongs_to :recipe, optional: true

  enum time: { breakfast: 0, lunch: 1, dinner: 2, others: 3 }
  enum unit: { portion: 0, weight: 1 }
end
