# frozen_string_literal: true

class PostCoffee < ApplicationRecord
  belongs_to :user
  belongs_to :coffee_brew
  belongs_to :coffee
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :set_coffee_beans, dependent: :destroy
  has_many :coffee_beans, through: :set_coffee_beans
  has_many :notifications, dependent: :destroy

  validates :post_name, presence: true, length: { maximum: 25 }
  validates :post_explanation, presence: true, length: { maximum: 200 }
  validates :coffee_bean_ids, presence: true

  has_one_attached :image

  # 投稿画像の設定
  def get_image
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/post_coffee.jpg")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image
  end

  # お気に入りの設定
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 下書き機能
  enum status: { published: 0, draft: 1 }


  # 新しい順・古い順
  scope :latest, -> { order(created_at: :desc) } # 　投稿新しい
  scope :old, -> { order(created_at: :asc) } # 　投稿古い

  # コメント通知
  def create_notification_coffee_comment(current_user)
    notification = current_user.active_notifications.new(post_coffee_id: id, visited_id: user_id, action: "coffee_comment")
    if notification.visiter_id == notification.visited_id
      notification.checked = true # 自分には通知がこないようにする
    end
    notification.save if notification.valid?
  end

  # お気に入り通知
  def create_notification_favorite(current_user)
    notification = current_user.active_notifications.new(post_coffee_id: id, visited_id: user_id, action: "favorite")
    if notification.visiter_id == notification.visited_id
      notification.checked = true # 自分には通知がこないようにする
    end
    notification.save if notification.valid?
  end
end
