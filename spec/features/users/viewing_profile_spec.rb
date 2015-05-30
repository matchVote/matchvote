require "rails_helper"
require "support/authentication"

feature "Viewing a user's profile" do
  given(:user) { create(:user) }
  given(:rep)  { create(:representative, slug: "hey-bob") }

  background do
    sign_in(user)
  end

  scenario "when the user is a citizen, profile pic links to citizen profile" do
    expect(page).to have_selector(:xpath, "//a[@href='#{citizen_path(user)}']")
  end

  scenario "when the user is a rep_admin, profile pic links to their rep profile" do
    user = create(:user, username: "bob1", rep_admin: true, rep_slug: rep.slug)
    visit root_path
    expect(page).to have_selector(:xpath, "//a[@href='#{rep_path(rep.slug)}']")
  end
end

