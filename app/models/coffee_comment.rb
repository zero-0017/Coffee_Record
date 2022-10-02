class CoffeeComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_coffee
end
