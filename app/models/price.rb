class Price < ApplicationRecord

  belongs_to :customer
  belongs_to :food

end
