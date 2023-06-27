class CuttingBoardFood < ApplicationRecord

  belongs_to :customer
  belongs_to :food

  validates :amount, presence: true

  def per_weight
  
  end


end
