class RemoveTypeFromRiders < ActiveRecord::Migration
  def change
    remove_column :riders, :type, :string
  end
end
