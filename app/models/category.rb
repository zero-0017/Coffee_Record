class Category < ApplicationRecord
  has_many :post_coffees, dependent: :destroy

  validates :category_name, presence:true
end
