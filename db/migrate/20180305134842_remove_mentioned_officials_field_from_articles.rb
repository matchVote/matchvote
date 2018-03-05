class RemoveMentionedOfficialsFieldFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :mentioned_officials, :string
  end
end
