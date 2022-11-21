# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: "Admin.Record.0017@coffee.com",
    password: "Azzx567.1004y.V"
  )


User.create!(
  [
    {
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/coffee_user_1.png"),
      filename: "coffee_user_1.jpg"),
      name: "珈琲一郎",
      introduction: "珈琲一郎です",
      email: "coffee.2071@com",
      password: "test5567"},
    {
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/coffee_user_2.png"),
      filename: "coffee_user_2.jpg"),
      name: "珈琲二郎",
      introduction: "珈琲二郎です",
      email: "coffee.1573@com",
      password: "test5067"},
    {
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/coffee_user_3.png"),
      filename: "coffee_user_3.jpg"),
      name: "珈琲三郎",
      introduction: "珈琲三郎です",
      email: "coffee.4147@com",
      password: "test5167"},
    {
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/coffee_user_4.png"),
      filename: "coffee_user_4.jpg"),
      name: "珈琲太郎",
      introduction: "珈琲太郎です",
      email: "coffee.7022@com",
      password: "test1082"},
    {
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/coffee_user_5.png"),
      filename: "coffee_user_5.jpg"),
      name: "珈琲ヤロウ",
      introduction: "珈琲ヤロウです",
      email: "coffee.5638@com",
      password: "test8610"}
  ]
)


CoffeeBrew.create!(
    [
      {
        coffee_brew_name: "ペーパードリップ"
      },
      {
        coffee_brew_name: "インスタントコーヒー"
      },
      {
        coffee_brew_name: "ネルドリップ"
      },
      {
        coffee_brew_name: "エアロプレス"
      },
      {
        coffee_brew_name: "サイフォン"
      },
      {
        coffee_brew_name: "コーヒーメーカー"
      },
      {
        coffee_brew_name: "ウォータードリップ"
      },
      {
        coffee_brew_name: "フレンチプレス"
      },
      {
        coffee_brew_name: "パーコレーター"
      },
      {
        coffee_brew_name: "エスプレッソ"
      },
      {
        coffee_brew_name: "その他"
      }
    ]
  )


Coffee.create!(
    [
      {
        coffee_name: "ブラックコーヒー"
      },
      {
        coffee_name: "微糖コーヒー"
      },
      {
        coffee_name: "ストレートコーヒー"
      },
      {
        coffee_name: "ブレンドコーヒー"
      },
      {
        coffee_name: "アメリカンコーヒー"
      },
      {
        coffee_name: "ウィンナーコーヒー"
      },
      {
        coffee_name: "カフェオレ"
      },
      {
        coffee_name: "ダッチコーヒー"
      },
      {
        coffee_name: "エスプレッソ"
      },
      {
        coffee_name: "カフェラテ"
      },
      {
        coffee_name: "カプチーノ"
      },
      {
        coffee_name: "カフェマキアート"
      },
      {
        coffee_name: "カフェモカ"
      },
      {
        coffee_name: "その他"
      }
    ]
  )


CoffeeBean.create!(
    [
      {
        coffee_bean_name: "ディピカ"
      },
      {
        coffee_bean_name: "ブルボン"
      },
      {
        coffee_bean_name: "アマレロ"
      },
      {
        coffee_bean_name: "ムンドノーボ"
      },
      {
        coffee_bean_name: "カトゥーラ"
      },
      {
        coffee_bean_name: "カトゥアイ"
      },
      {
        coffee_bean_name: "マラゴジッペ"
      },
      {
        coffee_bean_name: "スマトラ"
      },
      {
        coffee_bean_name: "アルーシャ"
      },
      {
        coffee_bean_name: "ケント"
      },
      {
        coffee_bean_name: "ブルーマウンテン"
      },
      {
        coffee_bean_name: "ゲイシャ"
      },
      {
        coffee_bean_name: "サン・ラモン"
      },
      {
        coffee_bean_name: "パーカス"
      },
      {
        coffee_bean_name: "パカマラ"
      },
      {
        coffee_bean_name: "ジャバニカ"
      },
      {
        coffee_bean_name: "パーピュラセンス"
      },
      {
        coffee_bean_name: "ビジャサルチ"
      },
      {
        coffee_bean_name: "コナ"
      },
      {
        coffee_bean_name: "ブルボンポワントゥ"
      },
      {
        coffee_bean_name: "SL28"
      },
      {
        coffee_bean_name: "SL34"
      },
      {
        coffee_bean_name: "ルイルイレブン"
      },
      {
        coffee_bean_name: "ハイブリッドティモール"
      },
      {
        coffee_bean_name: "カティモール"
      },
      {
        coffee_bean_name: "コロンビア"
      },
      {
        coffee_bean_name: "カスティージョ"
      },
      {
        coffee_bean_name: "イカトゥ"
      },
      {
        coffee_bean_name: "その他"
      },
      {
        coffee_bean_name: "不明"
      }
    ]
  )
