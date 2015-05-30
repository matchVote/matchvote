class AddExternalIdsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :external_ids, :hstore
  end
end
