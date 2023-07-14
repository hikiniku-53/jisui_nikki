class Diary < ApplicationRecord
  has_many :meals, dependent: :destroy
  belongs_to :customer
end
