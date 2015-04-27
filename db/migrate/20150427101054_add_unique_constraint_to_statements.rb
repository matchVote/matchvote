class AddUniqueConstraintToStatements < ActiveRecord::Migration
  def up
    execute("alter table statements add unique (text);")
  end

  def down
    execute("alter table statements drop constraint if exists statements_text_key;")
  end
end
