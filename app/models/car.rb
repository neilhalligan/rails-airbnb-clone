class Car < ApplicationRecord
  has_attachment :car_image
  belongs_to :user
  has_many :users, through: :bookings

  validates :model, presence: true
  validates :brand, presence: true
  validates :description, presence: true

end
