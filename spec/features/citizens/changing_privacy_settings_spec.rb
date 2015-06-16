require "rails_helper"
require "support/page_objects/edit_profile_page"
require "support/page_objects/profile_page"
require "support/page_objects/privacy_settings_modal"

feature "Changing privacy settings" do
  given(:user) { create(:user) }
  given(:profile) { ProfilePage.new(user) }
  given(:edit_profile) { EditProfilePage.new(user) }
  given(:privacy_settings) { edit_profile.privacy_settings_modal }
  subject { page }

  background do
    edit_profile.visit
  end

  scenario "clicking Edit Privacy displays a modal" do
    privacy_settings.display
    expect(privacy_settings).to be_visible
  end

  feature "Toggling Display Stances" do
    scenario "displays citizen stances when active" do
      privacy_settings.display
      privacy_settings.activate_display_stances
      edit_profile.view_profile
      expect(profile).to have_stances_displayed
    end

    scenario "hides citizen stances when active" do
    end
  end
end
