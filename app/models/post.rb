class Post < ApplicationRecord

  #アソシエーション
  belongs_to :user

  #バリデーション
  validates :text, presence: true

  #投稿画像用
  has_one_attached :image
  #投稿画像があればtrueをなければfalseを返す(画像はあってもなくてもOK)
  def was_attached?
    self.image.attached?
  end

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

end
