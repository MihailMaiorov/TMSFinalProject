# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products

  validates :title, presence: true, length: { minimum: 2 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id title updated_at]
  end
end
