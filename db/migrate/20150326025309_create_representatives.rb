class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives, id: :uuid do |t|
      t.text :bioguide_id
      t.text :title
      t.text :first_name, index: true, null: false
      t.text :last_name, index: true, null: false
      t.text :middle_name
      t.text :suffix
      t.text :official_full_name
      t.text :nickname
      t.text :birthday
      t.text :gender
      t.text :orientation
      t.text :government_role
      t.text :state
      t.text :state_rank
      t.text :district
      t.text :party
      t.text :branch
      t.text :religion
      t.text :status
      t.boolean :verified
      t.text :profile_image_url
      t.text :slug
      t.text :biography
      t.hstore :external_credentials
      t.references :user, index: true
    end

    add_index :representatives, [:first_name, :last_name], unique: true
  end
end
