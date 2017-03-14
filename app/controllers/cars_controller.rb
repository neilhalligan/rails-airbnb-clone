class CarsController < ApplicationController
  before_action :set_car, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index , :show, :search ]

  def search


    # @q = "#{params[:query]}"
    @l = params[:location]
    @cars_l = []
    # @cars_q = []
    @cars_q = Car.search_by_model_and_brand(params[:query])
    @cars_l += Car.near(@l, 200) # change back to 10
    # @q.split.each do |q|
    #   q.insert(-1,"%").insert(0,"%")
    #   @cars_q << Car.where("brand ILIKE ? or description ILIKE ? or model ILIKE ?", q, q, q).to_a
    # end
    # @cars_q.uniq!full_name
    # raise
    if params[:location].blank?
      @cars = @cars_q
    # elsif @cars_q.blank?
    elsif params[:query].blank?
      @cars = @cars_l
    else
      @cars = @cars_l.select { |elem| @cars_q.include?(elem) }
    end
    # @cars.flatten!
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

  def edit
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
