class UpdateStancesToBePolymorphic < ActiveRecord::Migration
  def up
    remove_column :stances, :profile_id
    add_column :stances, :opinionable_id, :uuid
    add_column :stances, :opinionable_type, :string
    add_index :stances, [:opinionable_type, :opinionable_id]
  end

  def down
    remove_index :stances, [:opinionable_type, :opinionable_id]
    remove_column :stances, :opinionable_type
    remove_column :stances, :opinionable_id
    add_column :stances, :profile_id, :integer
  end
end
