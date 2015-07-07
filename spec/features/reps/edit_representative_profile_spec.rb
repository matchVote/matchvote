require "rails_helper"
require "support/authentication"
require "support/page_objects/edit_rep_profile_page"

feature "Edit Representative profile" do
  given(:profile) { EditRepProfilePage.new(user, rep) }
  given(:rep) { create(:representative) }
  given(:other_rep) { create(:representative) }
  given(:user) do
    create(:user, rep_admin: true, profile_type: "Representative", profile_id: rep.id)
  end

  background do |example|
    profile.signin_and_visit_rep_profile unless example.metadata[:skip_before]
  end

  context "when user is admin", :skip_before do
    given(:user) { create(:user, admin: true) }
    given(:profile) { EditRepProfilePage.new(user, rep) }

    background do
      profile.signin_and_visit_rep_profile
    end

    scenario "the edit button is visible on all rep profiles" do
      expect(profile).to have_edit_button
      profile.visit_another_rep_page(other_rep)
      expect(profile).to have_edit_button
    end

    scenario "the profile is editable by user" do
      profile.visit
      expect(profile).to be_editable
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

