# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    association :user, factory: :user
    association :category, factory: :category

    name { 'Botl' }
    price { 100 }
    status { 'in stock' }
  end
end
