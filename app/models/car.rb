class Car < ApplicationRecord
  belongs_to :user

  validate :model, presence: true
  validate :brand, presence: true
  validate :description, presence: true
end
