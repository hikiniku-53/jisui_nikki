class Food < ApplicationRecord
  has_one_attached :image
  has_many :prices, dependent: :destroy
  has_many :cutting_board_foods, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_details, dependent: :destroy
  belongs_to :food_genre

  validates :name, presence: true
  validates :energy, presence: true
  validates :protein, presence: true
  validates :fat, presence: true
  validates :carb, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search(keyword)
    where('name LIKE?', "%#{keyword}%")
  end
end
