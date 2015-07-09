class AddReligiousPreferenceToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :religious_preference, :string
  end
end
