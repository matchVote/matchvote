class ChangeIssuesTable < ActiveRecord::Migration
  def change
    rename_table :issues, :issue_categories
    add_column :issue_categories, :keywords, :string, array: true, default: []
  end
end
