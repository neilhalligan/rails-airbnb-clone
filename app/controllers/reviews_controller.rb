class ReviewsController < ApplicationController
  before_action :set_booking

  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    if @review.save
      respond_to do |format|
        format.html { redirect_to car_path(@review.car) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'cars/show' }
        format.js  # <-- idem
      end
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end


  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
