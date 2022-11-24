FactoryBot.define do
  factory :coffee_comment, class: CoffeeComment do
    comment { Faker::Lorem.characters(number: 100) }
  end
end