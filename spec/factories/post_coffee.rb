FactoryBot.define do
  factory :post_coffee, class: PostCoffee do
    post_name { Faker::Lorem.characters(number: 25) }
    post_explanation { Faker::Lorem.characters(number: 200) }
    coffee_bean_ids { FactoryBot.create(:coffee_bean).id }
    coffee_brew
    coffee
    user
  end
end