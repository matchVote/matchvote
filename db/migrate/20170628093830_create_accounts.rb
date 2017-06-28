class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.text :account_type, null: false
      t.references :user, type: :uuid, foreign_key: true, index: true
      t.timestamps
    end
  end
end
