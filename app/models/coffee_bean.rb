# frozen_string_literal: true

class CoffeeBean < ApplicationRecord
  has_many :set_coffee_beans, dependent: :destroy
  has_many :post_coffees, through: :set_coffee_beans

  validates :coffee_bean_name, presence: true
end
