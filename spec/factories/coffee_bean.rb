# frozen_string_literal: true

FactoryBot.define do
  factory :coffee_bean, class: CoffeeBean do
    coffee_bean_name { Faker::Lorem.characters(number: 5) }
  end
end
