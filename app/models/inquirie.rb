class Inquirie < ApplicationRecord
  belongs_to :user

  validates :title, presence:true, length: { maximum: 10 }
  validates :body, presence:true, length: { maximum: 200 }

  enum inquirie_type: { 投稿について: 0, 会員について: 1, 機能について: 2, 珈琲の淹れ方について: 3, 珈琲の種類について: 4, 珈琲豆の種類について: 5, その他: 6 }
  enum status: { 未対応: 0, 対応中: 1, 対応済: 2 }
end
