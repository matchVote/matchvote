require "rails_helper"
require "support/matchers/appear_before"
require "support/page_objects/directory_page"

feature "Sorting reps" do
  given(:user) { create(:user) }
  given(:directory) { DirectoryPage.new(user) }
  subject { page }

  background do
    @sortable_reps = directory.create_sortable_reps
    directory.signin_and_visit
  end

  scenario "remains filtered by search when a new sort is used", :js do
    skip "React"
    # directory.search_for "Carpenter"
    # select "Alphabetically", from: "Sort"
    # expect(subject).to have_content "Alice Carpenter"
    # expect(subject).to have_content "Bob Carpenter"
    # expect(subject).not_to have_content "Gene Krupa"
  end

  scenario "alphabetically", :js do
    skip "React"
    # select "Alphabetically", from: "Sort"
    # expect("Alice Carpenter").to appear_before("Bob Carpenter")
    # expect("Bob Carpenter").to appear_before("Gene Krupa")
    # expect("Gene Krupa").to appear_before("David Krusty")
    # expect("David Krusty").to appear_before("Buddy Rich")
  end

  scenario "by name recognition", :js do
    skip "React"
    # select "Name Recognition", from: "Sort"
    # directory.wait_for_ajax
    # expect("Bob Carpenter").to appear_before("Gene Krupa")
    # expect("Gene Krupa").to appear_before("David Krusty")
    # expect("David Krusty").to appear_before("Buddy Rich")
    # expect("Buddy Rich").to appear_before("Alice Carpenter")
  end

  scenario "by age", :js do
    skip "React"
    # select "Age", from: "Sort"
    # directory.wait_for_ajax
    # expect("David Krusty").to appear_before("Gene Krupa")
    # expect("Gene Krupa").to appear_before("Buddy Rich")
    # expect("Buddy Rich").to appear_before("Alice Carpenter")
    # expect("Alice Carpenter").to appear_before("Bob Carpenter")
  end

  scenario "by seniority", :js do
    skip "React"
    # select "Longest Serving", from: "Sort"
    # directory.wait_for_ajax
    # expect("Alice Carpenter").to appear_before("Bob Carpenter")
    # expect("Bob Carpenter").to appear_before("David Krusty")
    # expect("David Krusty").to appear_before("Buddy Rich")
    # expect("Buddy Rich").to appear_before("Gene Krupa")
  end

  scenario "by most similar views", :js do
    skip "React"
    # directory.create_stances_for_matching(@sortable_reps, user)
    # directory.refresh
    # select "Most Similar Views", from: "Sort"
    # directory.wait_for_ajax
    # expect("Alice Carpenter").to appear_before("Bob Carpenter")
    # expect("Bob Carpenter").to appear_before("David Krusty")
    # expect("David Krusty").to appear_before("Buddy Rich")
    # expect("Buddy Rich").to appear_before("Gene Krupa")
  end

  scenario "by least similar views", :js do
    skip "React"
    # directory.create_stances_for_matching(@sortable_reps, user)
    # directory.refresh
    # select "Least Similar Views", from: "Sort"
    # directory.wait_for_ajax
    # expect("Gene Krupa").to appear_before("Buddy Rich")
    # expect("Buddy Rich").to appear_before("David Krusty")
    # expect("David Krusty").to appear_before("Bob Carpenter")
    # expect("Bob Carpenter").to appear_before("Alice Carpenter")
  end

  scenario "by state", :js do
    skip "React"
    # select "State", from: "Sort"
    # directory.wait_for_ajax
    # expect("David Krusty").to appear_before("Bob Carpenter")
    # expect("Bob Carpenter").to appear_before("Gene Krupa")
    # expect("Gene Krupa").to appear_before("Buddy Rich")
    # expect("Buddy Rich").to appear_before("Alice Carpenter")
  end

  scenario "by approval rating", :js do
    skip "Not implemented"
  end
end

