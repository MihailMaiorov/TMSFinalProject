FactoryBot.define do
  factory :reviewed_product
  factory :reviewed_user

  factory :review do
    transient do
      commentable { nil }
    end

    association :user, factory: :user

    comment { 'Botl' }
    rating { 100 }
    reviewable_id { reviewable.id }
    reviewable_type { reviewable.class.name }
  end
end
