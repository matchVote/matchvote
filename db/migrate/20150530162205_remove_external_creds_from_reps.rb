class RemoveExternalCredsFromReps < ActiveRecord::Migration
  def change
    remove_column :representatives, :external_credentials, :hstore
  end
end
