class AddCarImageToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :car_image, :string
  end
end
