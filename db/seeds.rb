# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者アカウント追加
Admin.create!(
  email: "e-fufu@example.com",
  password: "e-fufu"
)

#開発終わったら消す
(1..10).each do |n|
  User.create!(
      name: "user#{n}",
      email: "user#{n}@test.com",
      password: "password"
    )
end

#初期状態でのカテゴリを追加
categories = %w(
    家事
    育児/妊活
    お金事情
    夜の生活
    スキンシップ
    結婚
    惚気話
    お悩み相談
    パートナーへ
  )

categories.each do |name|
  Category.create!(name: name)
end