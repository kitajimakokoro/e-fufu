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

#初期状態でのユーザーを追加
users = User.create!(
  [
    #通常ユーザー
    {email: 'iifuuchan@example.com',
     name: 'いーふーちゃん',
     password: 'password',
     profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"), filename:"sample-user1.png"),
     age: User.ages[:thirties] ,
     gender: User.genders[:woman],
     status: User.statuses[:married],
     introduction: '宜しくお願いします！'
    },

    {email: 'couple@example.com',
     name: 'しあわせちゃん',
     password: 'password',
     profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename:"sample-user2.png"),
     age: User.ages[:secret] ,
     gender: User.genders[:woman],
     status: User.statuses[:engaged],
     introduction: '気ままに投稿していきます。'
    },

    {email: 'hitorikunn@example.com',
     name: 'ひとりくん',
     password: 'password',
     profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"), filename:"sample-user3.png"),
     age: User.ages[:twenties] ,
     gender: User.genders[:man],
     status: User.statuses[:relationship],
     introduction: '彼女のホンネだと思って投稿見てます。'
    },

    #プロフィール未設定ユーザー
    {email: 'otonakunn@example.com',
     name: 'おとなくん',
     password: 'password',
    },

    #退会済ユーザー
    {email: 'fuufukun@example.com',
     name: 'ふうふくん',
     password: 'password',
     profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.png"), filename:"sample-user4.png"),
     is_deleted: true
    }

  ]
)

#初期状態での投稿を追加
posts = Post.create!(
  [
    {category_id: Category.find_by(name: "惚気話").id,
     image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.png"), filename:"sample-post1.png"),
     text: '今日は旦那さんがお誕生日なのでちょっと頑張ってケーキ作ってみた！喜んでくれるかな～！',
     user_id: users[1].id
    },

    {category_id: Category.find_by(name: "育児/妊活").id,
     text: 'つわりで全然ご飯たべれないし家事も手付かず、、何にもやる気でないなあ。でもおなかの赤ちゃんのためにご飯！ちゃんと食す！気合い！',
     user_id: users[0].id
    },

    {category_id: Category.find_by(name: "お金事情").id,
     text: '毎日節約意識して生きてるのになかなか二人の貯金がたまらない！でも旦那さんも協力してくれてるから、他にどこ削れるかって一緒に話すの楽しい！！！',
     user_id: users[1].id
    },

    {category_id: Category.find_by(name: "スキンシップ").id,
     text: 'ハグとか習慣的にしてるけどほんと大事だなーと思う！スキンシップ大事！癒し！',
     user_id: users[3].id
    },

    {category_id: Category.find_by(name: "家事").id,
     text: '家事の分担ってやっぱりちゃんと決めた方が良いのかな？お互いできる方がやればいいみたいな考え方だけど僕の帰りが遅いから結局奥さんがほぼやってくれてて申し訳ないな...',
     user_id: users[3].id
    },

    {category_id: Category.find_by(name: "夜の生活").id,
     text: 'いまだに勇気が出なくて自分から誘えない、、、いつも任せっぱなしだから私も頑張りたいーーーーーー！',
     user_id: users[1].id
    },

    {category_id: Category.find_by(name: "お悩み相談").id,
     text: '彼女と同棲中です。結婚されている方に聞きたいのですが結婚の決め手とかタイミングとかって何かあったのでしょうか？何卒経験談アドバイスください！',
     user_id: users[2].id
    },

    {category_id: Category.find_by(name: "パートナーへ").id,
     text: '旦那さんいつもお仕事本当にお疲れ様なのですが靴下裏返しにして洗濯機にいれるのだけはやめてくれないか、、、そこだけずっと治らん、、、',
     user_id: users[0].id
    },

    {category_id: Category.find_by(name: "お悩み相談").id,
     text: '旦那さんのここが良い！奥さんのこんなところが良い！を教えてください！！！参考にします！！！',
     user_id: users[2].id
    },

    {category_id: Category.find_by(name: "育児/妊活").id,
     text: '離乳食手作りするの最初はしんどかったけどなんかもう趣味みたいになってきたわ。',
     user_id: users[0].id
    },

    {category_id: Category.find_by(name: "惚気話").id,
     image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.png"), filename:"sample-post2.png"),
     text: '旦那さんが優しすぎる、、、昨日の夜ご飯の料理失敗しちゃったんだけど絶対的まずさなのに全部食べてくれた、、、尊い、、、いつもありがとう、、、',
     user_id: users[1].id
    },

    {category_id: Category.find_by(name: "結婚").id,
     text: '結婚式まであと１ヶ月切ったー！！ダイエットもラストスパートだから炭水化物控えめにしてジムいってって毎日忙しいけどほんと楽しみだなーーーーー！',
     user_id: users[1].id
    },

    {category_id: Category.find_by(name: "結婚").id,
     text: '結婚決意する前に既婚の友達全員に結婚の決め手聞いといてよかった、、、めっちゃリアルでなんか勉強になったな～。彼女とももう一回ちゃんと話してみよう！',
     user_id: users[2].id
    },

    #退会済ユーザーの投稿
    {category_id: Category.find_by(name: "パートナーへ").id,
     text: '退会済ユーザーの投稿です。これは投稿一覧画面に表示されないはずです。投稿詳細画面も表示されないはずです。※管理者画面には表示されます。',
     user_id: users[4].id
    },

  ]
)

#初期状態でのコメントを追加
PostComment.create!(
  [
    {post_id: posts[1].id,
     comment: 'お身体大事にしてください、、、',
     user_id: users[2].id
    },

    {post_id: posts[8].id,
     comment: '圧倒的顔です。なんでも許せます。',
     user_id: users[0].id
    },

    {post_id: posts[8].id,
     comment: 'ありがとうとごめんねがちゃんと言えるとこです！',
     user_id: users[3].id
    },

    {post_id: posts[6].id,
     comment: '私は同棲半年越したあたりにもうプロポーズしてもらいました！',
     user_id: users[1].id
    },

    #退会済ユーザーのコメント
    {post_id: posts[1].id,
     comment: '退会済ユーザーのコメントです。これは投稿詳細画面で【退会済ユーザー】このコメントは削除されました。と表示されます。※管理者画面には表記の通り表示されます。',
     user_id: users[4].id
    },

  ]
)

