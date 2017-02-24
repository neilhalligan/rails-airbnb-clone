class Car < ApplicationRecord
  has_attachments :car_image, maximum: 5
  belongs_to :user
  has_many :users, through: :bookings
  has_many :bookings, dependent: :destroy

  validates :model, presence: true
  validates :brand, presence: true
  validates :location, presence: true
  validates :price, presence: true

  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
