require "rails_helper"
require "support/authentication"

feature "Edit Representative profile" do
  given(:user) { create(:user) }
  given(:rep) { create(:representative) }

  subject { page }

  background do
    sign_in(user)
    visit rep_path(rep.slug)
  end

  context "when user is admin" do
    given(:user) { create(:user, admin: true) }

    scenario "the edit button is visible on the rep profile page" do
      expect(subject).to have_link("Edit")
    end
  end

  context "when user is not authorized to edit the rep" do
    scenario "the edit button is not visible on the rep profile page" do
      expect(subject).not_to have_link("Edit")
    end

    scenario "requesting the edit url directly redirects to the root url" do
      visit edit_representative_path(rep)
      expect(current_url).to eq root_url
      expect(subject).to have_content("You are not authorized")
    end
  end
end

