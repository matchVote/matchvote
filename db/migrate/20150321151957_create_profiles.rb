class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :type # STI
      t.text :title
      t.text :first_name, index: true, null: false
      t.text :last_name, index: true, null: false
      t.text :middle_names
      t.text :suffix
      t.text :birthday
      t.string :gender
      t.text :government_role
      t.string :state
      t.text :district
      t.text :party
      t.text :email, array: true, default: []
      t.text :phone, array: true, default: []
      t.text :biography
      t.text :religion
      t.hstore :external_credentials
      t.references :user, index: true
    end

    add_index :profiles, [:first_name, :last_name], unique: true
  end
end
