# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :post_coffees, dependent: :destroy

  validates :tag_name, presence: true
end
