class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_index :users, :avatar
  end
end
