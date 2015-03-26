class ChangeProfileIdOnContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :profile_id
    add_column :contacts, :representative_id, :uuid
    add_index :contacts, :representative_id, unique: true
  end

  def down
    remove_index :contacts, :representative_id
    remove_column :contacts, :representative_id
    add_column :contacts, :profile_id, :uuid
  end
end
