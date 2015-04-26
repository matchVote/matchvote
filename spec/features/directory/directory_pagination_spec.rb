require "rails_helper"
require "support/directory"

feature "Paginating reps" do
  given(:user) { create(:user) }
  given(:per_page) { 5 }
  subject { page }

  background do
    allow_any_instance_of(DirectoryController).
      to receive(:per_page).and_return(per_page)
    per_page.times { create(:representative, last_name: "Keyser") }
    per_page.times { create(:representative, last_name: "Söze") }
    per_page.times { create(:representative, last_name: "Balki") }
    login_as(user, scope: :user)
    visit root_path
  end

  it { is_expected.to have_css(".pagination") }

  scenario "visiting the directory has all reps paginated" do
    within(".pagination") do
      expect(subject).to have_content(1)
      expect(subject).to have_content(2)
      expect(subject).to have_content(3)
      expect(subject).not_to have_content(4)
    end
  end

  scenario "clicking 'Next' shows the next page of reps", js: true do
    rep_name = subject.all(".full_name").first.text
    subject.find(".pagination .next_page").click
    expect(subject).not_to have_content(rep_name)
  end

  scenario "sorting reps and switching pages keeps them sorted", js: true do
    select("Alphabetically", from: "Sort")
    expect(subject).to have_content("Balki")
    subject.find(".pagination .next_page").click
    expect(subject).not_to have_content("Balki")
    expect(subject).to have_content("Keyser")
  end

  scenario "fewer reps than the per page limit provides no pagination", js: true do
    search_for "Keyser"
    expect(subject).to have_no_selector(".pagination")
  end
end

