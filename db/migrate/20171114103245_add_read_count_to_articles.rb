class AddReadCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :read_count, :integer, default: 0
  end
end
