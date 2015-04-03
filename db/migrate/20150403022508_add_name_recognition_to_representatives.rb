class AddNameRecognitionToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :name_recognition, :integer, limit: 8
  end
end
