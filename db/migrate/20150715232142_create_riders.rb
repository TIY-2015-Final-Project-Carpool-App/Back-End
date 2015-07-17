class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.integer :appointment_id
      t.integer :ridable_id
      t.string :ridable_type
      t.integer :distance_from_origin
      t.integer :distance_from_destination

      t.timestamps null: false
    end
  end
end
