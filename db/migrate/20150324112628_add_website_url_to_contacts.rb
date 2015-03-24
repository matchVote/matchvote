class AddWebsiteUrlToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :website_url, :text
  end
end
