class CommentGenre < ApplicationRecord
  has_many :comments, dependent: :destroy
end
