# frozen_string_literal: true

class CoffeeComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_coffee

  validates :comment, presence: true, length: { maximum: 100 }

  # 管理者側の検索
  def self.looks(search, word)
    if search == "perfect_match"
      @coffee_comment = CoffeeComment.where("comment LIKE?", "#{word}")
    elsif search == "forward_match"
      @coffee_comment = CoffeeComment.where("comment LIKE?", "#{word}%")
    elsif search == "backward_match"
      @coffee_comment = CoffeeComment.where("comment LIKE?", "%#{word}")
    elsif search == "partial_match"
      @coffee_comment = CoffeeComment.where("comment LIKE?", "%#{word}%")
    else
      @coffee_comment = CoffeeComment.all
    end
  end
end
