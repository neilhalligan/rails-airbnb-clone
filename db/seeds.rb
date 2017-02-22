# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.destroy_all
Car.destroy_all
Review.destroy_all
Booking.destroy_all

# cars = [
#     { brand: "Peugot", model: "235", description: "mint" },
#     { brand: "Ford", model: "F-150", description: "shitty" },
#     { brand: "Chevy", model: "Tahoe", description: "mint" },
#     { brand: "Audi", model: "A8", description: "great" },
#     { brand: "Jeep", model: "Cherokee", description: "worn" },
#     { brand: "Cadillac", model: "Escalade", description: "good" },
# ]

# user = User.create!(name: "neil", email: "neil@gmail.com", password: "111111")

# cars.each do |car|
#   new_car = Car.new(car)
#   new_car.user = user
#   new_car.save!
# end
