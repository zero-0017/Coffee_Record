class PostCoffee < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  belongs_to :category
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :coffee_genres, dependent: :destroy
  has_many :genres, through: :coffee_genres

  validates :coffee_name, presence:true
  validates :coffee_explanation, presence:true, length: { maximum: 200 }
  validates :genre_ids, presence:true

  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/post_coffee.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

# 下書き機能
  enum status: { published: 0, draft: 1 }

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
