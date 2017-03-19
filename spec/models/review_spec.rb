require 'rails_helper'

RSpec.describe "Review", type: :model do
  let(:valid_attributes) do
    {
     content: "text",
     rating: 4
    }
  end

  it "has content" do
    review = Review.new(content: "text")
    expect(review.content).to eq("text")
  end

  it "has rating" do
    review = Review.new(rating: 4)
    expect(review.rating).to eq(4)
  end

  it "belongs to booking" do
    booking = Booking.new
    review = Review.new(booking: booking)
    expect(review.booking).to eq(booking)
  end

  it "has one user" do
    user = User.create!(email: "john@gmail.com",
                        password: "123456")
    review = Review.new(valid_attributes.merge(user: user))
    expect(review.user).to eq(user)
  end
end
