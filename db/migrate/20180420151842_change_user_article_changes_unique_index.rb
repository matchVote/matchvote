class ChangeUserArticleChangesUniqueIndex < ActiveRecord::Migration
  def up
    remove_index :user_article_changes, [:article_id, :user_id]
    add_index :user_article_changes,
      [:article_id, :user_id, :change_type],
      name: "article_changes_artID_userID_type_idx",
      unique: true
  end

  def down
    remove_index :user_article_changes, name: "article_changes_artID_userID_type_idx"
    add_index :user_article_changes, [:article_id, :user_id], unique: true
  end
end
