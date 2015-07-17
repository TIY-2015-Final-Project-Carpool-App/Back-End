class AddRiderRoleToRiders < ActiveRecord::Migration
  def change
    add_column :riders, :rider_role, :string
  end
end
