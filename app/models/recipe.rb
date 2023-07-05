class Recipe < ApplicationRecord
  has_one_attached :image

  has_many :recipe_details, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :favorites, dependent: :destroy
  belongs_to :customer

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  def subtotal_energy
    recipe_details.sum(recipe_detail.subtotal_energy)
  end

  def subtotal_protein
    recipe_details.sum(recipe_detail.subtotal_protein)
  end

  def subtotal_fat
    recipe_details.sum(recipe_detail.subtotal_fat)
  end

  def subtotal_carb
    recipe_details.sum(recipe_detail.subtotal_carb)
  end

  def subtotal_salt_equivalent
    recipe_details.sum(recipe_detail.subtotal_salt_equivalent)
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(tag_name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_recipe_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_recipe_tag
    end
  end

  def self.search(keyword)
    where("name LIKE?","%#{keyword}%")
  end

  def favorited?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
