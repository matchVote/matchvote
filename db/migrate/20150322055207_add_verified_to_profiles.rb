class AddVerifiedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :verified, :boolean
  end
end
