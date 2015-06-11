require "rails_helper"
require "support/page_objects/edit_profile_page"

feature "Editing Citizen profile" do
  given(:user) { create(:user) }
  given(:profile) { EditProfilePage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  feature "Updating contact info" do
    scenario "displays existing citizen data" do
      expect(profile).to have_contact_info
    end

    scenario "persists changes for citizen", :js do
      profile.update_contact_info
      wait_for_ajax

      contact = User.first.contact
    end
  end
end

