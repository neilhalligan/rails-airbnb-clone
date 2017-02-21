class ReviewsController < ApplicationController
  before_action :set_booking


  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.save
  #     redirect_to dashboard
  #   else
  #     render bookings showpage
  #   end
  # end


  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
