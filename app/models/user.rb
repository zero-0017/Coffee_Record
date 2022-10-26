class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthableaaa
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_coffees, dependent: :destroy
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

# バリデーションの設定
  validates :name, presence:true, length: { maximum: 10 }
  validates :introduction, length: { maximum: 100 }

# 会員画像の設定
  has_one_attached :profile_image

# 会員画像の設定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #フォローするユーザー
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  #フォローされるユーザー
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower


# 管理者側の検索
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

# ゲストログインのアカウント
  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guestuse07r@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.introduction = "ゲストユーザーです。"
    end
  end


  #フォローした時
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォローを外した時
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォロー判定
  def following?(user)
    followings.include?(user)
  end


# フォローの通知機能
  def create_notification_follow(current_user)
    notification = current_user.active_notifications.new(visited_id: id, action: 'follow')
    notification.save if notification.valid?
  end
end