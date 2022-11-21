class CoffeeBrew < ApplicationRecord
  has_many :post_coffees, dependent: :destroy

  validates :coffee_brew_name, presence: true
end
