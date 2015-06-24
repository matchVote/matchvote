require "rails_helper"
require "support/matchers/appear_before"
require "support/page_objects/directory_page"

feature "Sorting reps" do
  given(:user) { create(:user) }
  given(:directory) { DirectoryPage.new(user) }
  subject { page }

  background do
    directory.create_sortable_reps
    directory.signin_and_visit
  end

  scenario "remains filtered by search when a new sort is used", :js do
    directory.search_for "Carpenter"
    select "Alphabetically", from: "Sort"
    expect(subject).to have_content "Alice Carpenter"
    expect(subject).to have_content "Bob Carpenter"
    expect(subject).not_to have_content "Gene Krupa"
  end

  scenario "alphabetically", :js do
    select "Alphabetically", from: "Sort"
    directory.wait_for_ajax
    expect("Alice Carpenter").to appear_before("Bob Carpenter")
    expect("Bob Carpenter").to appear_before("Gene Krupa")
    expect("Gene Krupa").to appear_before("David Krusty")
    expect("David Krusty").to appear_before("Buddy Rich")
  end

  scenario "by name recognition", :js do
    skip "Test not written"
  end

  scenario "by age", :js do
    skip "Test not written"
  end

  scenario "by seniority", :js do
    skip "Test not written"
  end

  scenario "by most similar views", :js do
    skip "Not implemented"
  end

  scenario "by least similar views", :js do
    skip "Not implemented"
  end

  scenario "by state", :js do
    skip "Not implemented"
  end

  scenario "by approval rating", :js do
    skip "Not implemented"
  end
end

