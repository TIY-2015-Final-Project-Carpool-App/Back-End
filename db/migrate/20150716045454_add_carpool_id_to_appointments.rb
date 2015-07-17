class AddCarpoolIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :carpool_id, :integer
  end
end
