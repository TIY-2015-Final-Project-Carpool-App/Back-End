class AddDescriptionToCarpools < ActiveRecord::Migration
  def change
    add_column :carpools, :description, :string
  end
end
