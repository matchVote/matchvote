class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.text :emails, array: true, default: []
      t.text :phone_numbers, array: true, default: []
      t.references :profile, index: true
    end
  end
end
