class AddStatusToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :status, :text
  end
end
