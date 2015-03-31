require "rails_helper"
require "support/authentication"

feature "Viewing Representative profile" do
  include ActionView::Helpers

  given(:user) { create(:user) }
  given(:rep) { create(:representative) }
  given(:address) { rep.contact.postal_addresses.first }
  subject { page }

  background do
    sign_in(user)
    visit rep_path(rep.slug)
  end

  it { is_expected.to have_content "Borky Buffet" }
  it { is_expected.to have_content truncate(rep.biography, length: 200) }
  it { is_expected.to have_content "March 8, 1967" }
  it { is_expected.to have_content "#{address.street_number} #{address.street_name}" }
  it { is_expected.to have_content "#{address.city}, #{address.state} #{address.zip}" }

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

