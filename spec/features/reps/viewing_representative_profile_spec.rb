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
      nickname: "Borky",
      status: "in_office")
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
  it { is_expected.to have_content "In Office" }

  scenario "social media buttons are not shown without rep links"

  feature "Clicking 'Read Full Bio' button" do
    scenario "expands the biography section to include more paragraphs"
  end

  feature "Following representative" do
    scenario "adds the rep to your following list"
  end
end

