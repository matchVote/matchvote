class AddBioguideToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :bioguide_id, :text
    add_index :profiles, :bioguide_id, unique: true
  end
end
