class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [ :dashboard ]

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    # @bookings = Booking.all
    @bookings = current_user.bookings
    # @bookings = current_user.(Booking.all)
    @cars = current_user.cars
    # @rental_cars = current_user.bookings.cars
  end
end
