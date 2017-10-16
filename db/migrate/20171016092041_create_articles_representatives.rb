class CreateArticlesRepresentatives < ActiveRecord::Migration
  def change
    create_table :articles_representatives do |t|
      t.uuid :representative_id
      t.integer :article_id
      t.timestamps
    end

    add_index :articles_representatives,
      [:representative_id, :article_id],
      unique: true,
      name: 'idx_articles_reps_primary_key'
  end
end
