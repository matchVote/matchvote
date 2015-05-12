class ChangeStatementTextToTextType < ActiveRecord::Migration
  def up
    change_column :statements, :text, :text
  end

  def down
    change_column :statements, :text, :string
  end
end
