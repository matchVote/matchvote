class AddProfileTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_type, :text
  end
end
