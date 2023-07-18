# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :reviews, as: :reviewable
  belongs_to :user
  belongs_to :category
  has_many_attached :pictures

  validates :name, presence: true, length: { minimum: 2 }

  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }

  validates :pictures, blob: { content_type: %w[image/png image/jpg image/jpeg], size_range: 1..5.megabytes }

  validates :category, presence: true

  scope :in_stock, -> { where(status: 'in stock') }

  def formatted_updated_at
    I18n.l updated_at, format: :long
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at description id name price status updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category pictures_attachments pictures_blobs reviews user]
  end
end
