class ChangeUsersIdToUuid < ActiveRecord::Migration
  def up
    remove_column :users, :id
    add_column :users, :id, :uuid, default: "uuid_generate_v4()"
    execute("alter table users add primary key (id)")
  end

  def down
    remove_column :users, :id
    add_column :users, :id, :primary_key
  end
end
