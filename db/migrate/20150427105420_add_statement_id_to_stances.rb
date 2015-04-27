class AddStatementIdToStances < ActiveRecord::Migration
  def change
    add_reference :stances, :statement, index: true
  end
end
