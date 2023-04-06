class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_many :posts, dependent: :destroy

  #enum管理
  enum age: { secret: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixties: 5 }
  enum gender: { privacy: 0, man: 1, woman: 2, other: 3 }
  enum status: { unpublished: 0, single: 1, relationship: 2, engaged: 3, married: 4, others: 5 }

  #profile_imageという記述でプロフィール画像を保存できる
  has_one_attached :profile_image
  #プロフィール画像が登録されていない時の処理＋画像サイズ調整
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
