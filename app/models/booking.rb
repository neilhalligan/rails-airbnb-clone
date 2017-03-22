class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :reviews, dependent: :destroy

  validates :car, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validate :check_booking_date

  private

  def end_date_after_start_date
    return if self.car.blank? || self.start_date.blank? || self.end_date.blank?
    if self.start_date >= self.end_date
      errors.add(:start_date, "Start date must be after end date")
    end
  end

  def check_booking_date
    return if self.car.blank? || self.start_date.blank? || self.end_date.blank?
    self.car.bookings.each do |booking|
      next if booking == self
      unless self.start_date > booking.end_date || self.end_date < booking.start_date
        errors.add(:end_date, "Car already booked for these dates")
      end
    end
  end
end
