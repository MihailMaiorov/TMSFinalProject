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
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :avatar, blob: { content_type: %w[image/png image/jpg image/jpeg], size_range: 1..5.megabytes }
  validates :email, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

  private

  def assign_default_role
    add_role(Role::USER)
  end
end
