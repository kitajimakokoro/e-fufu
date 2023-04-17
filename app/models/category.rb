class Category < ApplicationRecord

  #アソシエーション
  has_many :posts

  #バリデーション
  validates :name, presence: true

end
