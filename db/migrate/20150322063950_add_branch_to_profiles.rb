class AddBranchToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :branch, :string
  end
end
