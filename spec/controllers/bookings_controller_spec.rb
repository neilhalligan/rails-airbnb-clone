require 'rails_helper'
begin
  require "bookings_controller"
rescue LoadError
end

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
    { start_date: Date.new(2017,5,2),
      end_date: Date.new(2017,5,3),
      car: car,
    }
  end

  let(:invalid_attributes) do
    { start_date: Date.new(2017,5,2),
      end_date: Date.new(2017,1,3),
      car: car,
    }
  end

  describe "POST create" do

    before(:each) do
      sign_in user
    end

    context "with valid params" do

      it "it creates new booking" do
        expect {
          post :create, params: {car_id: car.id, booking: valid_attributes}
        }.to change(Booking, :count).by(1)
      end

      it "assigns booking to @booking_blank" do
        post :create, params: {car_id: car.id, booking: valid_attributes}
        expect(assigns(:booking_blank)).to be_persisted
      end

      it "redirects to dashboard_path" do
        post :create, params: {booking: valid_attributes, car_id: car.to_param}
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "without valid params" do

      it "doesnt save new booking" do
        expect {
          post :create, params: {car_id: car.id, booking: invalid_attributes}
        }.to_not change(Booking, :count)
      end

      it "renders cars/show template" do
        post :create, params: {car_id: car.id, booking: invalid_attributes}
        expect(response).to render_template("cars/show")
      end
    end
  end

  describe "POST update" do
    before(:each) do
      sign_in user
      @booking = Booking.create!(valid_attributes)
    end

    it "changes pending to false and saves" do
      put :update, params: {id: @booking.id, car_id: car.id}
      @booking.reload
      expect(@booking.pending).to eq(false)
    end

    it "re-renders dashboard" do
      put :update, params: {id: @booking.id, car_id: car.id}
      expect(response).to render_template("dashboards/dashboard")
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      sign_in user
      @booking = Booking.create!(valid_attributes)
    end

    it "destroys booking" do
      expect {
              delete :destroy, params: {id: @booking.id, car_id: car.id}
             }.to change(Booking, :count).by(-1)
    end

    it "redirects to dashboard" do
      delete :destroy, params: {id: @booking.id, car_id: car.id}
      expect(response).to redirect_to(dashboard_path)
    end

  end
end

