class CreateStanceEvents < ActiveRecord::Migration
  def change
    create_table :stance_events do |t|
      t.integer :action, default: 0, null: false
      t.integer :agreeance_value
      t.integer :importance_value
      t.references :stance, index: true
      t.references :statement, index: true
      t.references :issue_category, index: true
      t.references :opinionable, polymorphic: true, index: true, type: :uuid
      t.uuid :created_by, index: true
      t.timestamps
    end
  end
end
