require 'rails_helper'
begin
  require "cars_controller"
rescue LoadError
end

if defined?(CarsController)
  RSpec.describe CarsController, :type => :controller do

    let(:valid_attributes) do
      {
        model: "Nissan",
        brand: "265",
        location: "Dublin, Ireland",
        price: 50
      }
    end

    let(:car) do
      Car.create!(
                  model: "Nissan",
                  brand: "265",
                  location: "Dublin, Ireland",
                  price: 50
                 )
    end

    describe "GET index" do
      it "assigns all cocktails as @cocktails" do
        car = Car.create! valid_attributes
        get :index, params: {}
        expect(assigns(:cars)).to eq([car])
      end
    end

    describe "GET show" do
      it "assigns requested car as @car" do
        get :show, params: {id: car.to_param}
        expect(assigns(:car)).to eq(car)
      end

      it "assigns @booking_blank" do
        get :show, params: {id: car.to_param}
        expect(assigns(:booking_blank)).to be_a_new(Booking)
      end

      it "assigns @booking_review to nil if logged out" do
        get :show, params: {id: car.to_param}
        expect(@booking_review).to eq(nil)
      end

      it "assigns @booking_review if logged in" do
        current_user = User.new
        Booking.create!(user: current_user,
                        car: car,
                        start_date: Date.new(2017,1,2),
                        end_date: Date.new(2017,1,3)
                       )
        get :show, params: {id: car.to_param}
        expect(assigns(:booking_review)).to be_a(Booking)
      end

      it "assigns @review to a new review" do
        get :show, params: {id: car.to_param}
        expect(assigns(:review)).to be_a_new(Review)
      end
    end
  end

else
  describe "CarsController" do
    it "should exist" do
      expect(defined?(CarsController)).to eq(true)
    end
  end
end

# require 'rails_helper'
# begin
#   require 'cars_controller'
# rescue LoadError
# end

# if defined?(CarsController) do
#   RSpec.describe CocktailsController, type: :controller do

#     let(:valid_attributes) do
#       {
#         model: "Nissan",
#         brand: "265",
#         location: "Dublin, Ireland",
#         price: 50
#       }
#     end

#     let(:valid_session) {{ }}

#     describe "GET index" do
#       it "assigns all cars as @cars" do
#         car = Car.new valid_attributes
#         get :index, {}, valid_session
#         expect(assigns(:cars)).to eq([car])
#       end
#     end
#   end
# end
