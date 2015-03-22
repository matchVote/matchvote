class CreateStances < ActiveRecord::Migration
  def change
    create_table :stances do |t|
      t.text :description
      t.integer :agreeance_value
      t.integer :importance_value
      t.boolean :skipped
      t.references :profile, index: true
      t.references :issue, index: true
      t.timestamps
    end
  end
end
