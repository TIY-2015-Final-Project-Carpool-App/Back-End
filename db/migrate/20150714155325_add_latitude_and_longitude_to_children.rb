class AddLatitudeAndLongitudeToChildren < ActiveRecord::Migration
  def change
    add_column :children, :latitude, :float
    add_column :children, :longitude, :float
  end
end
