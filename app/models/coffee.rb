# frozen_string_literal: true

class Coffee < ApplicationRecord
  has_many :post_coffees, dependent: :destroy

  validates :coffee_name, presence: true
end
