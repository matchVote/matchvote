require "rails_helper"
require "support/page_objects/citizen_index_page"

feature "Viewing Citizen index" do
  given(:admin) { create(:user, admin: true) }
  given(:citizen) { create(:user, username: "josiah") }

  scenario "is only visible for admins" do
    index = CitizenIndexPage.new(admin)
    index.signin_and_visit
    expect(index).to be_visible
    index.signout

    index = CitizenIndexPage.new(citizen)
    index.signin_and_visit
    expect(index).not_to be_visible
  end
end

