class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :avatar

      t.timestamps null: false
    end
  end
end
