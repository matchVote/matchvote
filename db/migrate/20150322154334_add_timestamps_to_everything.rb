class AddTimestampsToEverything < ActiveRecord::Migration
  def change
    add_column :profiles, :created_at, :datetime
    add_column :profiles, :updated_at, :datetime

    add_column :contacts, :created_at, :datetime
    add_column :contacts, :updated_at, :datetime

    add_column :postal_addresses, :created_at, :datetime
    add_column :postal_addresses, :updated_at, :datetime
  end
end
