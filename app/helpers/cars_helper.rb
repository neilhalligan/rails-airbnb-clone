module CarsHelper
  def car_image?
    if @car.car_image?
      @car.car_image.path
    else
      "v1487707587/tdamefabs3mqikk9hrpr.jpg"
    end
  end

  def car_image_url?(car)
    if car.car_image?
      cl_image_path(car.car_image.path, width: 600, height: 400, crop: :fill)
    else
      "https://img.clipartfox.com/ee10ada04750133968c37e94c30c38b4_-clip-art-vintage-cars-and-classic-car-bw-clipart_1575-1260.jpeg"
    end
  end
end
