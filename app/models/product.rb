class Product < ApplicationRecord
  has_many :reviews, as: :reviewable
  belongs_to :user
  belongs_to :category
  has_many_attached :pictures

  validates :name, presence: true, length: { minimum: 2 }

  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }

  validates :pictures, blob: { content_type: %w[image/png image/jpg image/jpeg], size_range: 1..5.megabytes }

  def formatted_updated_at
    I18n.l updated_at, format: :long
  end
end
