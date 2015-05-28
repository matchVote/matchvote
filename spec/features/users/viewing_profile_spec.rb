require "rails_helper"
require "support/authentication"

feature "Viewing a user's profile" do
  include ApplicationHelper
  given(:user) { create(:user) }
  background { sign_in(user) }

  scenario "when the user is a citizen, it shows their profile" do
    expect(page).to have_selector(:xpath, "//a[@href]='#{citizen_path(user)}'")
  end
end

