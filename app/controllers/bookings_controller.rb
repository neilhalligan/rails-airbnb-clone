class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :activate]
  before_action :set_car, only: [:create, :destroy]
  before_action :authenticate_user!, only: [ :create ]

  # def activate
  #   @booking.pending = false
  # end

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
    booking_params[:start_date] = Date.parse(booking_params[:start_date])
    booking_params[:end_date] = Date.parse(booking_params[:end_date])
    @booking_blank = Booking.new(booking_params)
    @booking_blank.user = current_user
    @booking_blank.car = @car
    @booking_blank.pending = true
    @hash = cars_location_marker([@car])
    if @booking_blank.save
      redirect_to dashboard_path
    else
      render "cars/show"
    end
  end

  def edit

  end

  def update
    @booking.pending = false
    @booking.save
    redirect_to booking_path(@booking)
    # preferably give a flash msg to say booking accepted, no redirect (use ajax)
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

