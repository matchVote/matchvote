require "rails_helper"
require "support/directory"
require "support/wait_for_ajax"

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

  it { is_expected.not_to have_css(".pagination") }

  scenario "visiting the directory has all reps paginated" do
    expect(subject.all(".directory_block").size).to eq per_page
  end

  scenario "scrolling to the bottom appends the next page of reps", :js do
    scroll_to_bottom_of_page
    wait_for_ajax
    expect(subject.all(".directory_block").size).to eq(per_page * 2)
  end

  scenario "sorting reps and scrolling to the bottom keeps them sorted", :js do
    select("Alphabetically", from: "Sort")
    expect(subject).to have_content("Balki")
    expect(subject).not_to have_content("Keyser")
    scroll_to_bottom_of_page
    expect(subject).to have_content("Balki")
    expect(subject).to have_content("Keyser")
    expect(subject).not_to have_content("Söze")
    scroll_to_bottom_of_page
    expect(subject).to have_content("Söze")
  end

  scenario "fewer reps than the per page limit provides no pagination", :js do
    search_for "Keyser"
    scroll_to_bottom_of_page
    expect(subject).to have_no_selector(".pagination")
  end
end

