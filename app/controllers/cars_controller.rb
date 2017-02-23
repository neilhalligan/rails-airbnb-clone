class CarsController < ApplicationController
  before_action :set_car, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index , :show, :search ]

  def search
    @q = "#{params[:query]}"
    @l = "#{params[:location]}"
    # params[:entry].match(/(http|www|com|abc|def)/i)

    @cars = []
    @cars += Car.near(@l, 10)
    @q.split.each do |q|
      q.insert(-1,"%").insert(0,"%")
      @cars += Car.where("brand ILIKE ? or description ILIKE ? or model ILIKE ?", q, q, q)
      @cars.uniq!
    end
    @hash = cars_location_marker(@cars)
    render :search
  end

  def index
    @cars = Car.all
  end

  def show
    @booking = Booking.new
    @cars = [@car]
    @hash = cars_location_marker(@cars)
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

  def cars_location_marker(cars)
      Gmaps4rails.build_markers(@cars) do |car, marker|
      marker.lat car.latitude
      marker.lng car.longitude
    end
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:brand, :model, :description, :car_image, :location)
  end
end
