class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cars, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
