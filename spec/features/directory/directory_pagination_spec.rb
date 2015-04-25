require "rails_helper"

feature "Paginating reps" do
  given(:user) { create(:user) }
  given(:per_page) { DirectoryController::PER_PAGE }
  subject { page }

  background do
    per_page.times { create(:representative, last_name: "Keyser") }
    per_page.times { create(:representative, last_name: "Söze") }
    per_page.times { create(:representative, last_name: "Balki") }
    login_as(user, scope: :user)
    visit root_path
  end

  it { is_expected.to have_css(".pagination") }

  scenario "visiting the directory has all reps paginated" do
    pending
  end

  scenario "clicking 'Next' shows the next page of reps", js: true do
    rep_name = subject.all(".full_name").first.text
    subject.find(".pagination .next_page").click
    expect(subject).not_to have_content(rep_name)
  end
end

