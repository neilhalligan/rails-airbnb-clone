class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_car, only: [:create, :destroy]
  before_action :authenticate_user!, only: [ :create ]
  def show
    @review = Review.new
    @owner = @booking.car.user
    @renter = @booking.user
    @car = @booking.car
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.car = @car
    @booking.pending = true
    @hash = cars_location_marker([@car])
    if @booking.save
      redirect_to dashboard_path
    else
      render "cars/show"
    end
  end

  def edit
    @booking = Booking.update(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :edit # TODO confirm this works
    end
  end

  def update

  end

  def destroy
    @booking.destroy
    redirect_to dashboard_path
  end

  private

  def cars_location_marker(cars)
      Gmaps4rails.build_markers(cars) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
    end
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_car
    @car = Car.find(params[:car_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

