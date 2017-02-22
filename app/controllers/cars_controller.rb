class CarsController < ApplicationController
  before_action :set_car, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index , :show, :search ]

  def search
    @q = "%#{params[:query]}%"
    @cars = Car.where("brand LIKE ? or description LIKE ? or model LIKE ?", @q, @q, @q)
    # change below to reject
    # @cars = Car.where.not(latitude: nil, longitude: nil) if put map on index
    @hash = Gmaps4rails.build_markers(@cars) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
    end
    # marker.infowindow render_to_string(partial: "/cars/map_box", locals: { car: car })
    # when working, test with and without render
    # render :search
  end

  def index
    @cars = Car.all
  end

  def show
    @booking = Booking.new

    # @hash = Gmaps4rails.build_markers( lat: @car.latitude, lng: @car.longitude )
    # car_coordinates(@car)

  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    # TODO add other params (user)
    # TODO add check for photo (as default value is nil with cloudinary)
    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @car.update(car_params)
    if @car.save
      redirect_to car_path(@car)
    else
      render :edit # TODO confirm this works
    end
  end

  def destroy
    @car.destroy     # TODO set validations on booking side
    redirect_to cars_path  # TODO s/b dashboard
  end

  private

  def car_coordinates(car)
    # @car_coordinates = # not needed return
    { lat: @car.latitude, lng: @car.longitude }
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:brand, :model, :description, :car_image)
  end
end
