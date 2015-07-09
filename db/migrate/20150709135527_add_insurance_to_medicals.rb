class AddInsuranceToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :insurance, :string
  end
end
