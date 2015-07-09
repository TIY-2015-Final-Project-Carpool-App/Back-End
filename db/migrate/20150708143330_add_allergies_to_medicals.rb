class AddAllergiesToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :allergies, :string
  end
end
