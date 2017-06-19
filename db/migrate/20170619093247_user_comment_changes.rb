class UserCommentChanges < ActiveRecord::Migration
  def change
    create_table :user_comment_changes do |t|
      t.integer :comment_id
      t.uuid :user_id
      t.text :change_type
      t.timestamps
    end

    add_index :user_comment_changes, [:comment_id, :user_id], unique: true
  end
end
