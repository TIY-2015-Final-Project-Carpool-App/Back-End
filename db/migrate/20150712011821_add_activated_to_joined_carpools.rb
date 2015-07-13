class AddActivatedToJoinedCarpools < ActiveRecord::Migration
  def change
    add_column :joined_carpools, :activated, :boolean, default: false
  end
end
