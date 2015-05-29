class ChangeRepNameOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :rep_name, :rep_slug
  end
end
