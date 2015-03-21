class CreatePostalAddresses < ActiveRecord::Migration
  def change
    create_table :postal_addresses do |t|
      t.text :street_number
      t.text :street_name
      t.text :city
      t.text :state
      t.text :zip
      t.references :contact, index: true
    end
  end
end
