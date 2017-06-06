class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.text :url, null: false
      t.text :title
      t.string :authors, array: true, default: '{}'
      t.text :publisher, null: false
      t.text :date_published
      t.string :keywords, array: true, default: '{}'
      t.text :summary
      t.string :mentioned_officials, array: true, default: '{}'
      t.integer :read_time
      t.integer :newsworthiness_count
      t.text :top_image_url
      t.timestamps
    end

    add_index :articles, :url, unique: true
  end

  def down
    drop_table :articles
  end
end
