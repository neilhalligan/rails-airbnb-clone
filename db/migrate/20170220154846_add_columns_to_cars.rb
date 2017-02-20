class AddColumnsToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :description, :text
    add_column :cars, :user_image, :string
  end
end
