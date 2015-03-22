class AddNicknameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :nickname, :text
  end
end
