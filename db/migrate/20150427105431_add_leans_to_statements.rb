class AddLeansToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :lean, :text
    add_column :statements, :lean_weight, :integer
    change_column_null :statements, :text, false
  end
end
