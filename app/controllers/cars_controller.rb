class CarsController < ApplicationController
  before_action :set_car, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index , :show, :search ]

  def search
    @cars_l = []
    @cars_q = Car.search_by_model_and_brand(params[:query])
    @cars_l += Car.near(params[:location], 20)
    if params[:location].blank?
      @cars = @cars_q
    elsif params[:query].blank?
      @cars = @cars_l
    else
      @cars = @cars_l.select { |elem| @cars_q.include?(elem) }
    end
    @hash = cars_location_marker(@cars)
    render :search
  end

  def index
    @cars = Car.all
  end

  def show
    @booking_review = Booking.where(user: current_user, car: @car)[0]
    @booking_blank = Booking.new
    @review = Review.new
    @cars = [@car]
    @hash = cars_location_marker(@cars)
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    @car.update(car_params)
    if @car.save
      redirect_to car_path(@car)
    else
      render :edit
    end
  end

  def destroy
    @car.destroy
    redirect_to dashboard_path
  end

  private

  def cars_location_marker(cars)
      Gmaps4rails.build_markers(cars) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
    end
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:brand, :model, :description, :location, :price, car_image: [])
  end
end
