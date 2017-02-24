class ReviewsController < ApplicationController
  before_action :set_booking


  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    if @review.save
      redirect_to dashboard_path # not sure about this syntax
    else
      render "bookings/show" # not sure about this syntax
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
