# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 100) }
    password { "password" }
    password_confirmation { "password" }

    after(:build) do |user|
      user.profile_image.attach(io: File.open("spec/images/profile_image.png"), filename: "profile_image.png", content_type: "application/xlsx")
    end
  end
end
