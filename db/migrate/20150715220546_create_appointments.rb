class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :creator_id
      t.datetime :start
      t.string :title
      t.string :description
      t.string :origin
      t.float :origin_latitude
      t.float :origin_longitude
      t.string :destination
      t.float :destination_latitude
      t.float :destination_longitude

      t.timestamps null: false
    end
  end
end
