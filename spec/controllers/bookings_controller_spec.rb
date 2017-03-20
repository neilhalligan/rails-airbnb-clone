require 'rails_helper'
begin
  require "bookings_controller"
rescue LoadError
end

if defined?(BookingsController) do
  RSpec.describe BookingsController, type: :controller do

  let(:user) do
    User.create!(email: "john@gmail.com", password: "123456")
  end

  let(:car) do
    Car.create!(model: "Nissan",
                brand: "265",
                location: "Dublin, Ireland",
                price: 50,
                user: user)
  end

  let(:valid_attributes) do
    { start_date: Date.new(2017,1,2),
      end_date: Date.new(2017,1,3)
    }
  end

  describe


else
  describe "Bookings Controller" do
    it "should exist" do
      expect(defined?(BookingsController)).to eq(true)
    end
  end
end
