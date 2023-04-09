class Post < ApplicationRecord

  #アソシエーション
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  belongs_to :category

  #バリデーション
  validates :text, presence: true, length: { maximum: 500 }

  #投稿画像用
  has_one_attached :image
  #投稿画像があればtrueをなければfalseを返す(画像はあってもなくてもOK)
  def was_attached?
    self.image.attached?
  end

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  #いいね
  #引数で渡されたuser.idがlikesテーブルに存在するかどうか(exists?)調べる
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  #ブックマーク
  #引数で渡されたuser.idがbookmarksテーブルに存在するかどうか(exists?)調べる
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

end
