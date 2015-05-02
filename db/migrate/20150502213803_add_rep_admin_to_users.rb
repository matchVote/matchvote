class AddRepAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rep_admin, :boolean, default: false
    add_column :users, :rep_name, :text
  end
end
