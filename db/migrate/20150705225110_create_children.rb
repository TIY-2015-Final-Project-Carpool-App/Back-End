class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.date :dob
      t.string :address
      t.string :phone_number
      t.integer :height
      t.integer :weight

      t.timestamps null: false
    end
  end
end
