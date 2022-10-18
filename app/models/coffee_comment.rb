class CoffeeComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_coffee
  has_many :notifications, dependent: :destroy

validates :comment, presence: true, length: {maximum: 100}
end
