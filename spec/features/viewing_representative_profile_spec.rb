require "rails_helper"
require "support/authentication"

feature "Viewing Representative profile" do
  include ActionView::Helpers

  given(:user) { create(:user) }
  given(:address) { rep.contact.postal_addresses.first }
  given(:rep) do
    create(:representative, first_name: "Bob", last_name: "Buffet", nickname: "Borky")
  end

  subject { page }

  background do
    sign_in(user)
    visit rep_path(rep.slug)
  end

  it { is_expected.to have_content "Borky Buffet" }
  it { is_expected.to have_content truncate(rep.biography, length: 550) }
  it { is_expected.to have_content "March 8, 1967" }
  it { is_expected.to have_content "#{address.street_number} #{address.street_name}" }
  it { is_expected.to have_content "#{address.city}, #{address.state} #{address.zip}" }

  feature "Editing profile" do
    scenario "when user is not an admin, the edit link is absent" do
      expect(page).not_to have_link("Edit")
    end

    scenario "when user is an admin, the edit link is visible" do
      click_link("Log out")
      user.update_attribute(:admin, true)
      sign_in(user)
      visit rep_path(rep.slug)
      expect(page).to have_link("Edit")
    end
  end

  feature "Clicking 'Read Full Bio' button" do
    scenario "expands the biography section to include more paragraphs" do
      pending "Not implemented"
      fail
    end
  end

  feature "Following representative" do
    scenario "adds the rep to your following list" do
      pending "Not implemented"
      fail
    end
  end
end

