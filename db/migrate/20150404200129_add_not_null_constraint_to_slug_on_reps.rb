class AddNotNullConstraintToSlugOnReps < ActiveRecord::Migration
  def change
    change_column_null :representatives, :slug, false
  end
end
