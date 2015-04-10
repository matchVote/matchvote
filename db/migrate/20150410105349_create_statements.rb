class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string :text
      t.references :issue_category, index: true
      t.timestamps
    end
  end
end
