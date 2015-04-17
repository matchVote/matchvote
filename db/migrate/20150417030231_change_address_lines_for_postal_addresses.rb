class ChangeAddressLinesForPostalAddresses < ActiveRecord::Migration
  def up
    remove_column :postal_addresses, :street_number
    remove_column :postal_addresses, :street_name
    add_column :postal_addresses, :line1, :text
    add_column :postal_addresses, :line2, :text
  end

  def down
    remove_column :postal_addresses, :line1, :text
    remove_column :postal_addresses, :line2, :text
    add_column :postal_addresses, :street_number, :text
    add_column :postal_addresses, :street_name, :text
  end
end
