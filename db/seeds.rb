# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: 'Admin.Record.13@coffee.com',
    password: 'Azzx567.1004y.V'
)

User.create!(
    name: 'サンプル',
    email: 'test.0077@com',
    password: 'test5567'
)


User.create!(
    name: 'サンプルタロウ',
    email: 'test.0177@com',
    password: 'test5067'
)


User.create!(
    name: 'サンプルヤロウ',
    email: 'test.4077@com',
    password: 'test5167'
)


Tag.create!(
    [
      {
        tag_name: 'ペーパードリップ'
      },
      {
        tag_name: 'インスタントコーヒー'
      },
      {
        tag_name: 'ネルドリップ'
      },
      {
        tag_name: 'エアロプレス'
      },
      {
        tag_name: 'サイフォン'
      },
      {
        tag_name: 'コーヒーメーカー'
      },
      {
        tag_name: 'ウォータードリップ'
      },
      {
        tag_name: 'フレンチプレス'
      },
      {
        tag_name: 'パーコレーター'
      },
      {
        tag_name: 'エスプレッソ'
      },
      {
        tag_name: 'その他'
      }
    ]
  )


Category.create!(
    [
      {
        category_name: 'ブラックコーヒー'
      },
      {
        category_name: '微糖コーヒー'
      },
      {
        category_name: 'ストレートコーヒー'
      },
      {
        category_name: 'ブレンドコーヒー'
      },
      {
        category_name: 'アメリカンコーヒー'
      },
      {
        category_name: 'ウィンナーコーヒー'
      },
      {
        category_name: 'カフェオレ'
      },
      {
        category_name: 'ダッチコーヒー'
      },
      {
        category_name: 'エスプレッソ'
      },
      {
        category_name: 'カフェラテ'
      },
      {
        category_name: 'カプチーノ'
      },
      {
        category_name: 'カフェマキアート'
      },
      {
        category_name: 'カフェモカ'
      },
      {
        category_name: 'その他'
      }
    ]
  )


Genre.create!(
    [
      {
        genre_name: 'ディピカ'
      },
      {
        genre_name: 'ブルボン'
      },
      {
        genre_name: 'アマレロ'
      },
      {
        genre_name: 'ムンドノーボ'
      },
      {
        genre_name: 'カトゥーラ'
      },
      {
        genre_name: 'カトゥアイ'
      },
      {
        genre_name: 'マラゴジッペ'
      },
      {
        genre_name: 'スマトラ'
      },
      {
        genre_name: 'アルーシャ'
      },
      {
        genre_name: 'ケント'
      },
      {
        genre_name: 'ブルーマウンテン'
      },
      {
        genre_name: 'ゲイシャ'
      },
      {
        genre_name: 'サン・ラモン'
      },
      {
        genre_name: 'パーカス'
      },
      {
        genre_name: 'パカマラ'
      },
      {
        genre_name: 'ジャバニカ'
      },
      {
        genre_name: 'パーピュラセンス'
      },
      {
        genre_name: 'ビジャサルチ'
      },
      {
        genre_name: 'コナ'
      },
      {
        genre_name: 'ブルボンポワントゥ'
      },
      {
        genre_name: 'SL28'
      },
      {
        genre_name: 'SL34'
      },
      {
        genre_name: 'ルイルイレブン'
      },
      {
        genre_name: 'ハイブリッドティモール'
      },
      {
        genre_name: 'カティモール'
      },
      {
        genre_name: 'コロンビア'
      },
      {
        genre_name: 'カスティージョ'
      },
      {
        genre_name: 'イカトゥ'
      },
      {
        genre_name: 'その他'
      },
      {
        genre_name: '不明'
      }
    ]
  )