class RemovePasswordHashAndPasswordSaltFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_hash, :string
    remove_column :users, :password_salt, :string
  end
end
