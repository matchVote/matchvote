class ChangeStances < ActiveRecord::Migration
  def up
    remove_column :stances, :description
    remove_reference :stances, :issue
    add_column :stances, :inferred_by, :text
    add_column :stances, :verified, :boolean
  end

  def down
    add_column :stances, :description, :text
    add_reference :stances, :issue
    remove_column :stances, :inferred_by
    remove_column :stances, :verified
  end
end
