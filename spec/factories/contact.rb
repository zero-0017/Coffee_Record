# frozen_string_literal: true

FactoryBot.define do
  factory :contact, class: Contact do
    content { Faker::Lorem.characters(number: 200) }
    user
  end
end
