class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  def self.guest
    # ゲストユーザーの取り出しor作成
    find_or_create_by!(email: 'aaa@aaa.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
      customer.name = 'ゲスト'
    end
  end

end
