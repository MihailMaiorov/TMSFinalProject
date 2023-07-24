# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@gmail.com" }
    password { 'test_password' }
  end
end
