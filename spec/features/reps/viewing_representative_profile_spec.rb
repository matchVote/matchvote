require "rails_helper"
require "support/authentication"

feature "Viewing Representative profile" do
  include ActionView::Helpers

  given(:user) { create(:user) }
  given(:address) { rep.contact.postal_addresses.first }
  given(:rep) do
    create(:representative, 
      first_name: "Bob", 
      last_name: "Buffet", 
      nickname: "Borky")
  end

  subject { page }

  background do
    sign_in(user)
    visit rep_path(rep.slug)
  end

  it { is_expected.to have_content "Borky Buffet" }
  it { is_expected.to have_content truncate(rep.biography, length: 550) }
  it { is_expected.to have_content "March 8, 1967" }
  it { is_expected.to have_content "#{address.line1}" }
  it { is_expected.to have_content "#{address.city}, #{address.state} #{address.zip}" }

  feature "Editing profile" do
    context "when user is an admin" do
      given(:user) { create(:user, admin: true, email: "hey@there.com") }

      scenario "the edit link is visible" do
        expect(page).to have_link("Edit")
      end
    end

    context "when the profile belongs to the user" do
      given(:user) do
        create(:user, 
          email: "hey@there.com", 
          profile_id: rep.id, 
          profile_type: "Representative")
      end

      scenario "the edit link is visible" do
        expect(page).to have_link("Edit")
      end
    end

    context "when user does not have permission" do
      scenario "the edit link is absent" do
        expect(page).not_to have_link("Edit")
      end
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

