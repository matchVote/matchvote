class AddTimestampsToReps < ActiveRecord::Migration
  def change
    change_table(:representatives) { |t| t.timestamps }
  end
end
