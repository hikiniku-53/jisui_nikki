class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :comment_genre
  belongs_to :food

  validates :comment, presence: true
end
