class PostCoffee < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :coffee_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
end
