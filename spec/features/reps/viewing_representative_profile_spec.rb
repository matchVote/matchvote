require "rails_helper"
require "support/page_objects/reps/profile_page"

feature "Viewing Representative profile" do
  given(:profile) { Reps::ProfilePage.new(user, rep) }
  given(:user) { create(:user) }
  given(:address) { rep.contact.postal_addresses.first }
  given(:rep) do
    create(:representative, 
      first_name: "Bob", 
      last_name: "Buffet", 
      nickname: "Borky",
      status: "in_office")
  end

  subject { profile }

  background do
    profile.signin_and_visit
  end

  it { is_expected.to have_rep_name }
  it { is_expected.to have_rep_birthday }
  it { is_expected.to have_truncated_bio }
  it { is_expected.to have_contact_address }

  context "when user is admin" do
    scenario "the edit button is visible on all rep profiles" do
      profile.user.update(admin: true)
      profile.refresh
      expect(profile).to have_edit_button

      profile.visit_another_rep_page(create(:representative))
      expect(profile).to have_edit_button
    end
  end

  context "when user is the rep admin" do
    scenario "the edit button is visible only on that rep profile" do
      profile.user.update(
        rep_admin: true, profile_type: :Representative, profile_id: rep.id)
      profile.refresh
      expect(profile).to have_edit_button

      profile.visit_another_rep_page(create(:representative))
      expect(profile).not_to have_edit_button
    end
  end

  context "when user is not authorized" do
    scenario "the edit button is not visible on the rep profile page" do
      profile.user.update(rep_admin: false, admin: false)
      profile.refresh
      expect(profile).not_to have_edit_button
    end
  end

  scenario "social media buttons are not shown without rep links"

  feature "Clicking 'Read Full Bio' button" do
    scenario "expands the biography section to include more paragraphs"
  end

  feature "Following representative" do
    scenario "adds the rep to your following list"
  end
end

