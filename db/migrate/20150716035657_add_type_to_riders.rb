class AddTypeToRiders < ActiveRecord::Migration
  def change
    add_column :riders, :type, :string
  end
end
