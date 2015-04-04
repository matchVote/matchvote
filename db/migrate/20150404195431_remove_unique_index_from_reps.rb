class RemoveUniqueIndexFromReps < ActiveRecord::Migration
  def up
    remove_index :representatives, [:first_name, :last_name]
    add_index :representatives, [:first_name, :last_name]
  end

  def down
    remove_index :representatives, [:first_name, :last_name]
    add_index :representatives, [:first_name, :last_name]
  end
end
