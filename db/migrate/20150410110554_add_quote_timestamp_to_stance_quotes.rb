class AddQuoteTimestampToStanceQuotes < ActiveRecord::Migration
  def change
    add_column :stance_quotes, :quote_timestamp, :datetime
  end
end
