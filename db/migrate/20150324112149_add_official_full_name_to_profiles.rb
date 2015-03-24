class AddOfficialFullNameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :official_full_name, :text
  end
end
