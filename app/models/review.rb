class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true

  validates :comment, presence: true, length: { maximum: 300 }
  validates :rating, presence: true, numericality: { in: 1..5 }

  def formatted_updated_at
    I18n.l updated_at, format: :long
  end
end
