class CreateJoinedCarpools < ActiveRecord::Migration
  def change
    create_table :joined_carpools do |t|
      t.integer :carpool_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
