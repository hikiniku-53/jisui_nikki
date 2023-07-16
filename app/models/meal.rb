class Meal < ApplicationRecord

  belongs_to :customer
  belongs_to :food
  belongs_to :recipe

  enum time: { breakfast: 0, lunch: 1, dinner: 2, others: 3 }
end
