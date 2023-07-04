FactoryBot.define do
  factory :cart_item do
    association :product, factory: :product

    sequence(:quantity)
  end
end
