class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles, id: false do |t|
      t.text :url
      t.text :title
      t.string :authors, array: true, default: '{}'
      t.text :publisher, null: false
      t.datetime :date_published
      t.string :keywords, array: true, default: '{}'
      t.text :summary
      t.string :mentioned_officials, array: true, default: '{}'
      t.integer :read_time
      t.integer :newsworthiness_count
      t.timestamps
    end

    execute "ALTER TABLE articles ADD PRIMARY KEY (url)"
  end

  def down
    drop_table :articles
  end
end
