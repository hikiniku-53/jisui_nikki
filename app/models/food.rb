class Food < ApplicationRecord

  has_many :prices, dependent: :destroy
  has_many :cutting_boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_details, dependent: :destroy
  belongs_to :food_genre

end
