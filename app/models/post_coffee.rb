class PostCoffee < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  belongs_to :category
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :coffee_genres, dependent: :destroy
  has_many :genres, through: :coffee_genres


  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/profile_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

# 投稿名の検索
  def self.looks(search, word)
    if search == "perfect_match"
      @post_coffee = PostCoffee.where("coffee_name LIKE?","#{word}")
    elsif search == "forward_match"
      @post_coffee = PostCoffee.where("coffee_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post_coffee = PostCoffee.where("coffee_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post_coffee = PostCoffee.where("coffee_name LIKE?","%#{word}%")
    else
      @post_coffee = PostCoffee.all
    end
  end
end
