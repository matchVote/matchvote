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
    edit_profile.signin_and_visit
  end

  scenario "clicking Edit Privacy displays a modal" do
    privacy_settings.display_modal
    expect(privacy_settings).to be_visible
  end

  feature "Toggling Display All Stances" do
    scenario "displays all citizen stances when active" do
      user.settings(:privacy).display_all_stances = false
      privacy_settings.display_modal
      privacy_settings.hide_all_stances
      expect(privacy_settings).to have_all_options_checked
      edit_profile.view_profile
      expect(profile).not_to have_stances_displayed
    end

    scenario "hides citizen stances when active" do
      user.settings(:privacy).display_all_stances = true
      privacy_settings.display_modal
      privacy_settings.display_all_stances
      expect(privacy_settings).to have_no_options_checked
      edit_profile.view_profile
      expect(profile).to have_stances_displayed
    end
  end
end
