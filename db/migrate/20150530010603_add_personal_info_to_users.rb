class AddPersonalInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_info, :hstore
  end
end
