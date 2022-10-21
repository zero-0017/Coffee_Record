class PostCoffee < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  belongs_to :category
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :coffee_genres, dependent: :destroy
  has_many :genres, through: :coffee_genres
  has_many :notifications, dependent: :destroy

  validates :coffee_name, presence:true, length: { maximum: 10 }
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

  #新しい順・古い順
  scope :latest, -> {order(created_at: :desc)}#　投稿新しい
  scope :old, -> {order(created_at: :asc)}#　投稿古い

  # コメント通知
  def create_notification_coffee_comment(current_user)
    notification = current_user.active_notifications.new(post_coffee_id: id,visited_id: user_id,action: 'coffee_comment')
  if notification.visiter_id == notification.visited_id
      notification.checked = true
  end
    notification.save if notification.valid?# 自分には通知がこないようにする
  end

  # お気に入り通知
  def create_notification_favorite(current_user)
    notification = current_user.active_notifications.new(post_coffee_id: id,visited_id: user_id,action: 'favorite')
  if notification.visiter_id == notification.visited_id
      notification.checked = true
  end
    notification.save if notification.valid?# 自分には通知がこないようにする
  end
end
