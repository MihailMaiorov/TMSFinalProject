FactoryBot.define do
  factory :cart do
    association :user, factory: :user
  end
end
