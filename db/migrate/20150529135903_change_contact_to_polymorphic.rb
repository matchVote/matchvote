class ChangeContactToPolymorphic < ActiveRecord::Migration
  def up
    remove_column :contacts, :representative_id
    add_column :contacts, :contactable_id, :uuid
    add_column :contacts, :contactable_type, :string
    add_index :contacts, [:contactable_type, :contactable_id]
  end

  def down
    remove_index :contacts, [:contactable_type, :contactable_id]
    remove_column :contacts, :contactable_id
    remove_column :contacts, :contactable_type
    add_column :contacts, :representative_id, :uuid
  end
end
