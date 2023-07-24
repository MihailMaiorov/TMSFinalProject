# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@gmail.com" }
    password { 'test_password' }

    trait :with_role do
      after(:create) do |user|
        user.add_role :seller
      end
    end
  end
end
