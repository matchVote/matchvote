class AddOrientationToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :orientation, :text
  end
end
