class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :article_id
      t.uuid :user_id
      t.timestamps
    end

    add_index :bookmarks, [:article_id, :user_id], unique: true
  end
end
