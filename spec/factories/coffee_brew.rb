# frozen_string_literal: true

FactoryBot.define do
  factory :coffee_brew, class: CoffeeBrew do
    coffee_brew_name { Faker::Lorem.characters(number: 5) }
  end
end
