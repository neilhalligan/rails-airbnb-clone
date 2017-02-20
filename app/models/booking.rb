class Booking < ApplicationRecord
  belongs_to :user_id
  belongs_to :car_id

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, uniqueness: {scope: :car_id }
end
