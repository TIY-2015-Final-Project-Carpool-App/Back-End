class AddSeatsToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :seats, :integer
  end
end
