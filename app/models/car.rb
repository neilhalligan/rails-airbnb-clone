class Car < ApplicationRecord
  has_attachments :car_image, maximum: 5
  belongs_to :user
  has_many :users, through: :bookings
  has_many :bookings, dependent: :delete_all

  has_many :reviews, through: :bookings, dependent: :destroy_all

  validates :model, presence: true
  validates :brand, presence: true
  validates :location, presence: true
  validates :price, presence: true
  validates :user, presence: true

  geocoded_by :location
  before_validation :geocode, if: :location_changed?

  include PgSearch
   pg_search_scope :search_by_model_and_brand, :against => [:model, :brand],
                   :using => {:tsearch => {:prefix => true}}
end
