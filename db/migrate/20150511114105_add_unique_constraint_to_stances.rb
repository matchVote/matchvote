class AddUniqueConstraintToStances < ActiveRecord::Migration
  def change
    add_index :stances, [:opinionable_id, :statement_id], unique: true
  end
end
