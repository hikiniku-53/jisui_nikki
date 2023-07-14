class MealDetail < ApplicationRecord
  belongs_to :meal
  belongs_to :food
  belongs_to :recipe
end
