class Tag < ApplicationRecord
  has_many :post_coffees, dependent: :destroy
end
