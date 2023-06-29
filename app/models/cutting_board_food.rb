class CuttingBoardFood < ApplicationRecord

  belongs_to :customer
  belongs_to :food

  validates :amount, presence: true

  def energy
    food.energy * amount / 100
  end


end
