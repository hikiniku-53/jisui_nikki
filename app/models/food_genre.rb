class FoodGenre < ApplicationRecord
  has_many :foods, dependent: :destroy
end
