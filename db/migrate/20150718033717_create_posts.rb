class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :carpool_id
      t.integer :user_id
      t.string :urgency
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
