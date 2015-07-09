class AddBloodTypeToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :blood_type, :string
  end
end
