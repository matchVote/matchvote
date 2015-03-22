class AddStateRankToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :state_rank, :text
  end
end
