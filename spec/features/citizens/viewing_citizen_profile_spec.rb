require "rails_helper"
require "support/authentication"
require "support/page_objects/profile_page"

feature "Viewing Citizen profile" do
  given(:user) { create(:user, rep_admin: false) }
  given(:profile) { ProfilePage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  it { is_expected.to have_content user.username }
end

