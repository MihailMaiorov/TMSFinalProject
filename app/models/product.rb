class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true, length: { minimum: 2 }

  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }

  def formatted_create_at
    created_at.strftime('%Y-%m-%d %H-%M-%S')
  end
end
