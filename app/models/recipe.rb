class Recipe < ApplicationRecord
  has_one_attached :image

  has_many :recipe_details, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :customer

end
