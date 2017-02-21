class Car < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookings

  validates :model, presence: true
  validates :brand, presence: true
  validates :description, presence: true

end
