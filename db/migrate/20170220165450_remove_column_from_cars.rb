class RemoveColumnFromCars < ActiveRecord::Migration[5.0]
  def change
    remove_column :cars, :user_image, :string
  end
end
