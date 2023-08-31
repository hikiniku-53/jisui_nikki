class Price < ApplicationRecord

  belongs_to :customer
  belongs_to :food

  validates :food_price, presence: true

end
