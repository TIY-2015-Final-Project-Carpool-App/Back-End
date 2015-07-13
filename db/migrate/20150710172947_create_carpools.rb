class CreateCarpools < ActiveRecord::Migration
  def change
    create_table :carpools do |t|
      t.integer :creator_id
      t.string  :title

      t.timestamps null: false
    end
  end
end
