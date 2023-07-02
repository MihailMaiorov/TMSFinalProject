class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 300 }
  validates :rating, presence: true, numericality: { in: 1..5, message: 'Only numbres from 1 to 5' }

  scope :active, -> { where(archived: false) }

  def formatted_updated_at
    I18n.l updated_at, format: :long
  end
end
