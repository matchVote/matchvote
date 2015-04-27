class AddNotNullConstraintToIssueCategories < ActiveRecord::Migration
  def change
    change_column_null :issue_categories, :name, false
  end
end
