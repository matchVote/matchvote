class AddIndexToSlugOnRepresentatives < ActiveRecord::Migration
  def change
    add_index :representatives, :slug, unique: true
  end
end
