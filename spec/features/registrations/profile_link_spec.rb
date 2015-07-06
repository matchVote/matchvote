require "rails_helper"
require "support/page_objects/layout_header"

feature "Profile image link" do
  given(:user) { create(:user) }
  given(:rep)  { create(:representative, slug: "hey-bob") }
  given(:header) { LayoutHeader.new(user) }

  background do
    header.sign_in
  end

  scenario "when the user is a citizen, profile pic links to citizen profile" do
    header.click_profile_link
    expect(header).to be_citizen_profile
  end

  scenario "when the user is a rep_admin, profile pic links to their rep profile" do
    header.signout
    user = create(:user, username: "bob1", rep_admin: true, 
      profile_type: "Representative", profile_id: rep.id)
    header = LayoutHeader.new(user)
    header.sign_in
    header.click_profile_link
    expect(header).to be_rep_profile
  end
end

