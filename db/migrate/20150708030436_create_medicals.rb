class CreateMedicals < ActiveRecord::Migration
  def change
    create_table :medicals do |t|
      t.integer :child_id
      t.string :conditions
      t.string :medications
      t.string :notes

      t.timestamps null: false
    end
  end
end
