class AddLocationToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :location, :string
  end
end
