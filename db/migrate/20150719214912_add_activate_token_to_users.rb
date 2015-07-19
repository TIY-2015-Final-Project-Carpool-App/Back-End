class AddActivateTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activate_token, :string
  end
end
