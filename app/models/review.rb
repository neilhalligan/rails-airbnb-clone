class Review < ApplicationRecord
  belongs_to :booking
  validates :content, presence: true
  validates :rating, inclusion: { in: (0..5), allow_nil: false }, numericality: true
end
