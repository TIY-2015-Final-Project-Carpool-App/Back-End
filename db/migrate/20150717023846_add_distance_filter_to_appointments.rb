class AddDistanceFilterToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :distance_filter, :integer
  end
end
