FactoryBot.define do
  factory :coffee, class: Coffee do
    coffee_name { Faker::Lorem.characters(number: 5) }
  end
end