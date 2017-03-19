require 'rails_helper'
require 'date'

RSpec.describe "Car", :type => :model do
  let(:valid_attributes) do
    {
      model: "Nissan",
      brand: "265",
      location: "Dublin, Ireland",
      price: 50
    }
  end

  let(:john) do
    User.new(email: "john@gmail.com", password: "123456")
  end

  it "has a model" do
    car = Car.new(model: "265")
    expect(car.model).to eq("265")
  end

  it "has a brand" do
    car = Car.new(brand: "Nissan")
    expect(car.brand).to eq("Nissan")
  end

  it "has a location" do
    car = Car.new(location: "Dublin, Ireland")
    expect(car.location).to eq("Dublin, Ireland")
  end

  it "has a price" do
    car = Car.new(price: 50)
    expect(car.price).to eq(50)
  end

  it "has a description" do
    car = Car.new(description: "shiny")
    expect(car.description).to eq("shiny")
  end

  it "has latitude" do
    car = Car.new(latitude: 56.576)
    expect(car.latitude).to eq(56.576)
  end

  it "has longitude" do
    car = Car.new(latitude: 54.576)
    expect(car.latitude).to eq(54.576)
  end

  it "model cannot be blank" do
    valid_attributes.delete(:model)
    car = Car.new(valid_attributes)
    expect(car).not_to be_valid
  end

  it "brand cannot be blank" do
    valid_attributes.delete(:brand)
    car = Car.new(valid_attributes)
    expect(car).not_to be_valid
  end

  it "location cannot be blank" do
    valid_attributes.delete(:location)
    car = Car.new(valid_attributes)
    expect(car).not_to be_valid
  end

  it "price cannot be blank" do
    valid_attributes.delete(:location)
    car = Car.new(valid_attributes)
    expect(car).not_to be_valid
  end

  it "has many bookings" do
    car = Car.new(valid_attributes)
    expect(car).to respond_to(:bookings)
    expect(car.bookings.count).to eq(0)
  end

  it "has many reviews" do
    car = Car.new(valid_attributes)
    expect(car).to respond_to(:reviews)
    expect(car.reviews.count).to eq(0)
  end

  it "has many users" do
    car = Car.new(valid_attributes)
    expect(car).to respond_to(:users)
    expect(car.reviews.count).to eq(0)
  end

  it "belongs to user" do
    car = Car.new(user: john)
    expect(car.user).to eq(john)
  end

  it "destroys dependent bookings" do
    car = Car.new(valid_attributes)
    Booking.create!(start_date: Date.new(2017,1,2), end_date: Date.new(2017,1,3), car: car, user: john)
    expect { car.destroy }.to change { Booking.count }.by(-1)
  end
end


