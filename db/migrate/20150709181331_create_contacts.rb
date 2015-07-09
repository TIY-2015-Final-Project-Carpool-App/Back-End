class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :contactable, polymorphic: true, index: true
      t.string :first_name
      t.string :last_name
      t.string :relationship
      t.string :address
      t.string :phone_number
      t.string :alternate_number

      t.timestamps null: false
    end
  end
end
