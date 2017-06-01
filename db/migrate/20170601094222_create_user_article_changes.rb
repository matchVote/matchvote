class CreateUserArticleChanges < ActiveRecord::Migration
  def change
    create_table :user_article_changes do |t|
      t.integer :article_id
      t.uuid :user_id
      t.text :change_type
      t.timestamps
    end

    add_index :user_article_changes, [:article_id, :user_id], unique: true
  end
end
