FactoryBot.define do
  factory :cart_item do
    association :product, factory: :product
    # assotiation :cart, factory: :cart

    sequence(:quantity)
  end
end
