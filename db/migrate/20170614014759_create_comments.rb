class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.references :user, type: :uuid, foreign_key: true, index: true
      t.references :commentable, polymorphic: true
      t.timestamps
    end
  end
end
