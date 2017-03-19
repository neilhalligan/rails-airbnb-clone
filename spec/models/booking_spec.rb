require 'rails_helper'

RSpec.describe "Booking", type: :model do
  let(:valid_user) do
    User.create!(email: "john@gmail.com", password: "123456")
  end

  let(:valid_car) do
    Car.create!(model: "Nissan",
                brand: "265",
                location: "Dublin, Ireland",
                price: 50)
  end

  let(:valid_params) do
    { start_date: Date.new(2017,1,2),
      end_date: Date.new(2017,1,3)
    }
  end

  it "has many reviews" do
    booking = Booking.new(valid_params)
    expect(booking).to respond_to(:reviews)
    expect(booking.reviews.count).to eq(0)
  end

  it "belongs to user" do
    booking = Booking.new(user: valid_user)
    expect(booking.user).to eq(valid_user)
  end

  it "belongs to car" do
    booking = Booking.new(car: valid_car)
    expect(booking.car).to eq(valid_car)
  end

  it "has a start date" do
    booking = Booking.new(start_date: Date.new(2017,1,1))
    expect(booking.start_date).to eq(Date.new(2017,1,1))
  end

  it "has an end date" do
    booking = Booking.new(end_date: Date.new(2017,1,1))
    expect(booking.end_date).to eq(Date.new(2017,1,1))
  end

  it "has pending" do
    booking = Booking.new(pending: true)
    expect(booking.pending).to eq(true)
  end

  # it "start date cannot be blank" do
  #   valid_params.delete(:start_date)
  #   booking = Booking.new(valid_params)
  #   expect(booking).not_to be_valid
  # end

  # it "end date cannot be blank" do
  #   valid_params.delete(:end_date)
  #   booking = Booking.new(valid_params)
  #   expect(booking).not_to be_valid
  # end
end
