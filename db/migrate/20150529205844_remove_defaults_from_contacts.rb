class RemoveDefaultsFromContacts < ActiveRecord::Migration
  def change
    change_column_default :contacts, :phone_numbers, nil
    change_column_default :contacts, :emails, nil
  end
end
