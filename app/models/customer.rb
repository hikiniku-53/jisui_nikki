class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_many :cutting_board_foods, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.guest
    # ゲストユーザーの取り出しor作成
    find_or_create_by!(email: 'aaa@aaa.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
      customer.name = 'ゲスト'
    end
  end

end