class CarsController < ApplicationController
  before_action :set_car, only: [ :show, :edit, :update, :destroy]

  def index
    @cars = Car.all
  end

  def show
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
    @car = Car.patch(car_params)
    if @car.save
      redirect_to car_path(@car)
    else
      render :edit # TODO confirm this works
    end
  end

  def destroy
    @car.delete # what if
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:brand, :model)
  end
end
