require "rails_helper"
require "support/rep_creation"
require "support/matchers/appear_before"
require "support/directory"

feature "Sorting reps" do
  given(:user) { create(:user) }
  subject { page }

  background do
    create_sortable_reps
    login_as(user, scope: :user)
    visit root_path
  end

  scenario "remains filtered by search when a new sort is used", js: true do
    search_for "Carpenter"
    select("Alphabetically", from: "Sort")
    expect(subject).to have_content "Alice Carpenter"
    expect(subject).to have_content "Bob Carpenter"
    expect(subject).not_to have_content "Gene Krupa"
  end

  scenario "alphabetically", js: true do
    select("Alphabetically", from: "Sort")
    expect("Alice Carpenter").to appear_before("Bob Carpenter")
    expect("Bob Carpenter").to appear_before("Gene Krupa")
    expect("Gene Krupa").to appear_before("David Krusty")
    expect("David Krusty").to appear_before("Buddy Rich")
  end

  scenario "by name recognition", js: true do
    pending "Test not written"
    fail
  end

  scenario "by age", js: true do
    pending "Test not written"
    fail
  end

  scenario "by seniority", js: true do
    pending "Test not written"
    fail
  end

  scenario "by most similar views", js: true do
    pending "Not implemented"
    fail
  end

  scenario "by least similar views", js: true do
    pending "Not implemented"
    fail
  end

  scenario "by state", js: true do
    pending "Not implemented"
    fail
  end

  scenario "by approval rating", js: true do
    pending "Not implemented"
    fail
  end
end

