class Tag < ApplicationRecord
  # タグをまだ作成していないので、新規投稿時にエラーが発生するためコメントアウト
  # has_many :post_coffees, dependent: :destroy
end
