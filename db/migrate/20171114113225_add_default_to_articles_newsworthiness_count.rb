class AddDefaultToArticlesNewsworthinessCount < ActiveRecord::Migration
  def change
    change_column :articles, :newsworthiness_count, :integer, default: 0
  end
end
