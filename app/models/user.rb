class User < ApplicationRecord
  has_many :products, dependent: :destroy

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :avatar, blob: { content_type: %w[image/png image/jpg image/jpeg], size_range: 1..5.megabytes }
end
