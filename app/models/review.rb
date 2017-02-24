class Review < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking
  validates :content, presence: true
  validates :rating, inclusion: { in: (0..5), allow_nil: false }, numericality: true
end
