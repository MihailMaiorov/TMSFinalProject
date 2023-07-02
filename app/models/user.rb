class User < ApplicationRecord
  rolify
  has_many :products, dependent: :destroy
  has_many :reviews, as: :reviewable
  has_one :cart

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :avatar, blob: { content_type: %w[image/png image/jpg image/jpeg], size_range: 1..5.megabytes }
  validates :email,    presence: true
  validates :password, presence: true
end
