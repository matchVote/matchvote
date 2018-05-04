class CreatePollResponses < ActiveRecord::Migration
  def change
    create_table :poll_responses do |t|
      t.text :response
      t.uuid :user_id
      t.uuid :representative_id
      t.integer :article_id
    end

    add_index :poll_responses, [:user_id, :article_id]
  end
end
