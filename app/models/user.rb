# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_many :products, dependent: :destroy
  has_many :reviews, as: :reviewable
  has_many :cart_items, dependent: :destroy

  has_one_attached :avatar

  after_create :assign_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :avatar, blob: { content_type: %w[image/png image/jpg image/jpeg], size_range: 1..5.megabytes }
  validates :email, presence: true

  private

  def assign_default_role
    add_role(Role::USER) if roles.blank?
  end
end
