class AddMentionedCountToArticlesRepresentatives < ActiveRecord::Migration
  def change
    add_column :articles_representatives, :mentioned_count, :integer, default: 0
  end
end
