class Meal < ApplicationRecord

  belongs_to :customer
  belongs_to :food
  belongs_to :recipe

end
