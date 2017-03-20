require 'rails_helper'
begin
  require "cars_controller"
rescue LoadError
end

if defined?(CarsController)
  RSpec.describe CarsController, :type => :controller do

    let(:john) do
      User.create!(email: "john@gmail.com", password: "123456")
    end

    let(:valid_attributes) do
      {
        model: "Nissan",
        brand: "265",
        location: "Dublin, Ireland",
        price: 50,
        user: john
      }
    end

    let(:invalid_attributes) do
      {
        model: "Toyota",
        location: "Paris, France",
      }
    end

    let(:nissan) do
      Car.create!(
                  model: "Nissan",
                  brand: "265",
                  location: "Dublin, Ireland",
                  price: 50,
                  user: john
                 )
    end


    describe "GET index" do
      it "assigns all cars as @cars" do
        get :index, params: {}
        expect(assigns(:cars)).to eq([nissan])
      end
    end

    describe "GET show" do
      it "assigns requested car as @car" do
        get :show, params: {id: nissan.to_param}
        expect(assigns(:car)).to eq(nissan)
      end

      it "assigns @booking_blank" do
        get :show, params: {id: nissan.to_param}
        expect(assigns(:booking_blank)).to be_a_new(Booking)
      end

      it "assigns @booking_review to nil if logged out" do
        get :show, params: {id: nissan.to_param}
        expect(@booking_review).to eq(nil)
      end

      it "assigns @booking_review if logged in" do
        sign_in john
        Booking.create!(user: john,
                        car: nissan,
                        start_date: Date.new(2017,1,2),
                        end_date: Date.new(2017,1,3)
                       )
        get :show, params: {id: nissan.to_param}
        expect(assigns(:booking_review)).to be_a(Booking)
      end

      it "assigns @review to a new review" do
        get :show, params: {id: nissan.to_param}
        expect(assigns(:review)).to be_a_new(Review)
      end
    end

    describe "GET new" do
      it "assigns new car to @car" do
        sign_in john
        get :new
        expect(assigns(:car)).to be_a_new(Car)
      end
    end

    describe "POST create" do
      before(:each) do
        sign_in john
      end

      context "with valid params" do
        it "creates a new car" do
          expect {
                  post :create, params: { car: valid_attributes }
                 }.to change(Car, :count).by(1)
        end

        it "assigns created car to @car" do
          post :create, params: { car: valid_attributes }
          expect(assigns(:car)).to be_persisted
        end

        it "redirects to dashboard" do
          post :create, params: { car: valid_attributes }
          expect(response).to redirect_to(dashboard_path)
        end
      end

      context "without valid params" do
        it "does not save car" do
          expect {
                  post :create, params: { car: invalid_attributes}
                 }.to_not change(Car, :count)
        end

        it "re-renders new template" do
          post :create, params: { car: invalid_attributes }
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      before(:each) do
        sign_in john
      end

      context "with valid params" do
        before(:each) do
          put :update, params: {id: nissan.id, car:{ model: "Ferrari", price: 45 }}
        end

        it "located the requested car" do
          # put :update, params: {id: nissan.id, car:{model: "Ferrari", price: 45}}
          expect(assigns(:car)).to eq(nissan)
        end

        it "saves updated attributes" do
          # put :update, params: {id: nissan.id, car:{model: "Ferrari", price: 45}}
          nissan.reload
          expect(nissan.model).to eq("Ferrari")
          expect(nissan.price).to eq(45)
        end

        it "redirects to car_path" do
          expect(response).to redirect_to(car_path(nissan))
        end
      end

      context "without valid params" do
        before(:each) do
          put :update, params: {id: nissan.id, car:{ model: nil}}
        end

        it "locates the requested car" do
          expect(assigns(:car)).to eq(nissan)
        end

        it "doesnt save values" do
          nissan.reload
          expect(assigns(:car)).to eq(nissan)
        end

        it "re-renders edit template" do
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before(:each) do
        sign_in john
        @car = Car.create!(valid_attributes)
      end

      it "destroys car" do
        expect {
                delete :destroy, params: {id: @car.id}
               }.to change(Car, :count).by(-1)
      end

      it "redirects to dashboard" do
        delete :destroy, params: {id: @car.id}
        expect(response).to redirect_to(dashboard_path)
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

