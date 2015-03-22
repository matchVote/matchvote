class CreateStanceQuotes < ActiveRecord::Migration
  def change
    create_table :stance_quotes do |t|
      t.text :quote
      t.text :quote_url
      t.references :stance, index: true
      t.timestamps
    end
  end
end
