class ChangeDatePublishedToDatetimeForArticles < ActiveRecord::Migration
  def up
    execute <<-SQL
    ALTER TABLE articles
    ALTER COLUMN date_published TYPE timestamp without time zone
    USING date_published::timestamp without time zone
    SQL
  end

  def down
    execute <<-SQL
    ALTER TABLE articles
    ALTER COLUMN date_published TYPE text
    SQL
  end
end
