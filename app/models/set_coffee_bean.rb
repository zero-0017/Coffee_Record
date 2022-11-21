class SetCoffeeBean < ApplicationRecord
  belongs_to :post_coffee
  belongs_to :coffee_bean
end
