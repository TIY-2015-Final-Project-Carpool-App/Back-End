class RemoveBloodTypeFromChildren < ActiveRecord::Migration
  def change
    remove_column :children, :blood_type, :string
  end
end
