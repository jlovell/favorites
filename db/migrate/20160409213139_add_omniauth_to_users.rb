class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_provider, :string
    add_column :users, :auth_uid, :string
    add_column :users, :name, :string

    add_index :users, :auth_provider
    add_index :users, :auth_uid
    add_index :users, [:auth_provider, :auth_uid], unique: true
  end
end
