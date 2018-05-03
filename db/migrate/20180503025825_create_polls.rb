class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.text :response
      t.uuid :user_id
      t.uuid :representative_id
      t.integer :article_id
    end

    add_index :polls, :user_id
  end
end
