require "rails_helper"
require "support/page_objects/edit_profile_page"

feature "Editing Citizen profile" do
  given(:user) { create(:user) }
  given(:profile) { EditProfilePage.new(user) }
  subject { page }

  background do |example|
    profile.visit unless example.metadata[:skip_before]
  end

  feature "Updating contact info" do
    scenario "displays existing citizen data" do
      expect(profile).to have_contact_info
    end

    scenario "persists changes for citizen", :js do
      profile.update_contact_info
      wait_for_ajax

      contact = User.first.contact
      expect(contact.phone_numbers).to include "1231231231"
      expect(contact.external_ids).to eq(
        "twitter_username" => "flippy", 
        "youtube_username" => "youtubes",
        "facebook_username" => "facebook")

      address = contact.postal_addresses.first
      expect(address.line1).to eq "5 Blueberry Circle"
      expect(address.city).to eq "Panang"
      expect(address.state).to eq "WY"
      expect(address.zip).to eq "21212"
    end

    scenario "creates postal address if citizen doesn't have one", :js, :skip_before do
      profile = EditProfilePage.new(create(:user_without_address))
      profile.visit
      profile.update_contact_info
      wait_for_ajax
      expect(user.contact.postal_addresses).not_to be_blank
    end
  end
end

