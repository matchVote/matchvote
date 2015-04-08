require "rails_helper"
require "support/rep_creation"
require "support/matchers/appear_before"
require "support/directory"

feature "Searching for reps by name" do
  given(:user) { create(:user) }
  subject { page }

  background do
    create_searchable_reps
    login_as(user, scope: :user)
    visit root_path
  end

  it { is_expected.to have_content "Find elected officials" }

  scenario "displays reps matching first name", js: true do
    search_for "Jackson"
    expect(subject).to have_content "Jackson Franklin"
    expect(subject).not_to have_content "Barbara Walters"
    expect(subject).not_to have_content "Mannie Armstrong"
  end

  scenario "displays reps matching last name", js: true do
    search_for "Walters"
    expect(subject).to have_content "Barbara Walters"
    expect(subject).not_to have_content "Mannie Sanders"
    expect(subject).not_to have_content "Jackson Franklin"
  end

  scenario "displays reps matching nickname", js: true do
    search_for "Mannie"
    expect(subject).to have_content "Mannie Sanders"
    expect(subject).to have_content "Mannie Armstrong"
    expect(subject).to have_content "Mannie Nunkle"
    expect(subject).not_to have_content "Jackson Franklin"
    expect(subject).not_to have_content "Barbara Walters"
  end

  scenario "keeps the reps sorted by previous sort order", js: true do
    select("Alphabetically", from: "Sort")
    search_for "Mannie"
    expect("Mannie Armstrong").to appear_before("Mannie Nunkle")
    expect("Mannie Nunkle").to appear_before("Mannie Sanders")
  end
end

