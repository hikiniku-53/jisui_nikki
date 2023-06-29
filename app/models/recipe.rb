class Recipe < ApplicationRecord
  has_one_attached :image

  has_many :recipe_details, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :customer


  def subtotal_energy
    recipe_details.sum(recipe_detail.subtotal_energy)
  end

  def subtotal_protein
    recipe_details.sum(recipe_detail.subtotal_protein)
  end

  def subtotal_fat
    recipe_details.sum(recipe_detail.subtotal_fat)
  end

  def subtotal_carb
    recipe_details.sum(recipe_detail.subtotal_carb)
  end

  def subtotal_salt_equivalent
    recipe_details.sum(recipe_detail.subtotal_salt_equivalent)
  end

end
