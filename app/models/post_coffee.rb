class PostCoffee < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image
end
