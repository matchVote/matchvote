class AddOfficeToReps < ActiveRecord::Migration
  def change
    add_column :representatives, :office, :text
  end
end
