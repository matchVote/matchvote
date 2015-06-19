require "rails_helper"
require "support/authentication"

feature "Edit Representative profile" do
  given(:user) { create(:user) }
  given(:rep) { create(:representative) }
  given(:other_rep) { create(:representative) }

  subject { page }

  background do
    sign_in(user)
    visit rep_path(rep.slug)
  end

  context "when user is admin" do
    given(:user) { create(:user, admin: true) }

    scenario "the edit button is visible on all rep profiles" do
      expect(subject).to have_link("Edit")
      visit rep_path(other_rep.slug)
      expect(subject).to have_link("Edit")
    end

    scenario "the profile is editable by user" do
      visit edit_representative_path(rep)
      expect(subject).to have_content("Edit Bio")
    end
  end

  context "when profile belongs to user" do
    given(:user) { create(:user, profile_id: rep.id, profile_type: "Representative") }
    
    scenario "the edit button is visible on that rep's profile" do
      expect(subject).to have_link("Edit")
    end

    scenario "the edit button is not visible on any other profile" do
      visit rep_path(other_rep.slug)
      expect(subject).not_to have_link("Edit")
    end

    scenario "the profile is editable by user" do
      visit edit_representative_path(rep)
      expect(subject).to have_content("Edit Bio")
    end
  end

  context "when user is not authorized to edit the rep" do
    scenario "the edit button is not visible on the rep profile page" do
      expect(subject).not_to have_link("Edit")
    end

    scenario "requesting the edit url directly redirects to the root url" do
      visit edit_representative_path(rep)
      expect(current_url).to eq root_url
    end
  end
end

