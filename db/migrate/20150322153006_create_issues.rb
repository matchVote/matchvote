class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.text :name
      t.timestamps
    end

    add_index :issues, :name, unique: true
  end
end
