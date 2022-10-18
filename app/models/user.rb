class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_coffees, dependent: :destroy
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

# バリデーションの設定
  validates :name, presence:true, length: { maximum: 10 }

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

# ゲストログインのアカウント
  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guestuse07r@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end
end
