class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_car, only: [:create, :destroy]

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.car = @car
    @booking.pending = true
    if @booking.save
      redirect_to booking_path(@booking)
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
    redirect_to car_path(@car)  # TODO s/b dashboard
  end

  private

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

