class ChangeProfileIdTypeOnContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :profile_id
    add_column :contacts, :profile_id, :uuid
    add_index :contacts, :profile_id, unique: true
  end

  def down
    remove_index :contacts, :profile_id
    remove_column :contacts, :profile_id
    add_column :contacts, :profile_id, :integer
  end
end
