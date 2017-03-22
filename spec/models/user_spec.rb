require 'rails_helper'

RSpec.describe "User", type: :model do
  let(:valid_attributes) do
    {
      email: "frank@gmail.com",
      password: "1234567"
    }
  end

  let(:john) do
    User.create!(email: "john@gmail.com", password: "123456")
  end

  let(:valid_car) do
    Car.create!(model: "Nissan",
                brand: "265",
                location: "Dublin, Ireland",
                price: 50,
                user: john)
  end

  it "has many cars" do
    user = User.new
    expect(user).to respond_to(:cars)
    expect(user.cars.count).to eq(0)
  end

  it "has many bookings" do
    user = User.new
    expect(user).to respond_to(:bookings)
    expect(user.bookings.count).to eq(0)
  end

  it "has a name" do
    user = User.new(name: "john")
    expect(user.name).to eq("john")
  end

  it "has an email" do
    user = User.new(email: "john@gmail.com")
    expect(user.email).to eq("john@gmail.com")
  end

  it "has a password" do
    user = User.new(password: "123456")
    expect(user.password).to eq("123456")
  end

  it "destroys dependent cars" do
    user = User.new(valid_attributes)
    car = Car.create!(user: user, model: "123",
                      brand: "Nissan",
                      location: "Dublin, Ireland",
                      price: 35)
    expect { user.destroy }.to change { Car.count } .by(-1)
  end

  it "destroys dependent bookings" do
    user = User.new(valid_attributes)
    Booking.create!(user: user,
                    car: valid_car,
                    start_date: Date.new(2017,1,2),
                    end_date: Date.new(2017,1,3))
    expect { user.destroy }.to change {Booking.count}.by(-1)
  end

end
