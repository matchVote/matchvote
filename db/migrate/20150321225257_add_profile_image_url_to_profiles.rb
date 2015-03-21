class AddProfileImageUrlToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_image_url, :text
  end
end
