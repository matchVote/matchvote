require "rails_helper"
require "support/page_objects/edit_profile_page"
require "support/page_objects/profile_page"
require "support/page_objects/privacy_settings_modal"

feature "Changing privacy settings" do
  given(:user) { create(:user) }
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

  scenario "turning off Display All Stances sets user preference to false", :js do
    user.settings(:privacy).update(display_all_stances: "true")
    edit_profile.refresh
    privacy_settings.display_modal
    expect(privacy_settings.is_checked?(:display_all_stances)).to eq true

    privacy_settings.uncheck_display_all_stances
    privacy_settings.save_changes
    setting = user.reload.settings(:privacy).display_all_stances
    expect(setting).to eq "false"
  end

  scenario "turning on Display All Stances sets user preference to true", :js do
    user.settings(:privacy).update(display_all_stances: "false")
    edit_profile.refresh
    privacy_settings.display_modal
    expect(privacy_settings.is_checked?(:display_all_stances)).to eq false

    privacy_settings.check_display_all_stances
    privacy_settings.save_changes
    setting = user.reload.settings(:privacy).display_all_stances
    expect(setting).to eq "true"
  end
end

