class AddSeniorityDateToReps < ActiveRecord::Migration
  def change
    add_column :representatives, :seniority_date, :text
  end
end
