class AddBloodTypeToChildren < ActiveRecord::Migration
  def change
    add_column :children, :blood_type, :string
  end
end
