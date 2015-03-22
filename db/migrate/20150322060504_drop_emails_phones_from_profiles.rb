class DropEmailsPhonesFromProfiles < ActiveRecord::Migration
  def up
    remove_column :profiles, :email
    remove_column :profiles, :phone
  end

  def down
    add_column :profiles, :email, :text
    add_column :profiles, :phone, :text
  end
end
