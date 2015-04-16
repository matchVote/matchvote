class AddLine2ToPostalAddresses < ActiveRecord::Migration
  def change
    add_column :postal_addresses, :line2, :text
  end
end
