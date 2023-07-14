class Meal < ApplicationRecord

  has_many :meal_details, dependent: :destroy
  belongs_to :diary
end
