# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    association :product, factory: :product
    association :user, factory: :user

    sequence(:quantity)
  end
end
