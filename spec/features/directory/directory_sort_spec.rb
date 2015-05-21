require "rails_helper"
require "support/rep_creation"
require "support/matchers/appear_before"
require "support/directory"
require "support/wait_for_ajax"

feature "Sorting reps" do
  given(:user) { create(:user) }
  subject { page }

  background do
    create_sortable_reps
    login_as(user, scope: :user)
    visit root_path
  end

  scenario "remains filtered by search when a new sort is used", :js do
    search_for "Carpenter"
    select("Alphabetically", from: "Sort")
    expect(subject).to have_content "Alice Carpenter"
    expect(subject).to have_content "Bob Carpenter"
    expect(subject).not_to have_content "Gene Krupa"
  end

  scenario "alphabetically", :js do
    select("Alphabetically", from: "Sort")
    wait_for_ajax
    expect("Alice Carpenter").to appear_before("Bob Carpenter")
    expect("Bob Carpenter").to appear_before("Gene Krupa")
    expect("Gene Krupa").to appear_before("David Krusty")
    expect("David Krusty").to appear_before("Buddy Rich")
  end

  scenario "by name recognition", :js do
    pending "Test not written"
    fail
  end

  scenario "by age", :js do
    pending "Test not written"
    fail
  end

  scenario "by seniority", :js do
    pending "Test not written"
    fail
  end

  scenario "by most similar views", :js do
    pending "Not implemented"
    fail
  end

  scenario "by least similar views", :js do
    pending "Not implemented"
    fail
  end

  scenario "by state", :js do
    pending "Not implemented"
    fail
  end

  scenario "by approval rating", :js do
    pending "Not implemented"
    fail
  end
end

