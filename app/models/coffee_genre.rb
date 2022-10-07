class CoffeeGenre < ApplicationRecord
  belongs_to :post_coffee
  belongs_to :genre
end
