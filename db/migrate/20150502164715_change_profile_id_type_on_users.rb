class ChangeProfileIdTypeOnUsers < ActiveRecord::Migration
  def up
    remove_column :users, :profile_id
    add_column :users, :profile_id, :uuid
  end

  def down
  end
end
