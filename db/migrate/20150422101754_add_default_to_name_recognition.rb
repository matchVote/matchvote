class AddDefaultToNameRecognition < ActiveRecord::Migration
  def up
    change_column_default :representatives, :name_recognition, 0
  end

  def down
  end
end
