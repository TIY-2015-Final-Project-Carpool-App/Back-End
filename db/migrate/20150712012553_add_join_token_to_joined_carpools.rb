class AddJoinTokenToJoinedCarpools < ActiveRecord::Migration
  def change
    add_column :joined_carpools, :join_token, :string
  end
end
