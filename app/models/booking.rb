class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :reviews

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validate :check_booking_date

  private

  def end_date_after_start_date
    if self.start_date >= self.end_date
      errors.add(:start_date, "Start date must be after end date")
    end
  end

  def check_booking_date
    self.car.bookings.each do |booking|
      unless self.start_date > booking.end_date || self.end_date < booking.start_date
        errors.add(:end_date, "Car already booked for these dates")
      end
    end
  end
end
