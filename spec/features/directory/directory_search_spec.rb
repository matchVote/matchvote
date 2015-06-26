require "rails_helper"
require "support/matchers/appear_before"
require "support/page_objects/directory_page"

feature "Searching for reps by name" do
  given(:user) { create(:user) }
  given(:directory) { DirectoryPage.new(user) }
  subject { page }

  background do
    directory.create_searchable_reps
    directory.signin_and_visit
  end

  it { is_expected.to have_content "Find elected officials" }

  scenario "displays reps matching first name", :js do
    directory.search_for "Jackson"
    expect(subject).to have_content "Jackson Franklin"
    expect(subject).not_to have_content "Barbara Walters"
    expect(subject).not_to have_content "Mannie Armstrong"
  end

  scenario "displays reps matching last name", :js do
    directory.search_for "Walters"
    expect(subject).to have_content "Barbara Walters"
    expect(subject).not_to have_content "Mannie Sanders"
    expect(subject).not_to have_content "Jackson Franklin"
  end

  scenario "displays reps matching nickname", :js do
    directory.search_for "Mannie"
    expect(subject).to have_content "Mannie Sanders"
    expect(subject).to have_content "Mannie Armstrong"
    expect(subject).to have_content "Mannie Nunkle"
    expect(subject).not_to have_content "Jackson Franklin"
    expect(subject).not_to have_content "Barbara Walters"
  end

  scenario "keeps the reps sorted by previous sort order", :js do
    select "Alphabetically", from: "Sort"
    directory.search_for "Mannie"
    directory.wait_for_ajax
    expect("Mannie Armstrong").to appear_before("Mannie Nunkle")
    expect("Mannie Nunkle").to appear_before("Mannie Sanders")
  end
end

