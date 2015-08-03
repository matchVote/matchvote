# require "rails_helper"
# require "support/page_objects/directory_page"

# feature "Paginating reps" do
#   given(:user) { create(:user) }
#   given(:per_page) { 5 }
#   subject { DirectoryPage.new(user) }

#   background do
#     allow_any_instance_of(DirectoryController).
#       to receive(:per_page).and_return(per_page)
#     per_page.times { create(:representative, last_name: "Keyser") }
#     per_page.times { create(:representative, last_name: "Söze") }
#     per_page.times { create(:representative, last_name: "Balki") }
#     subject.signin_and_visit
#   end

#   it { is_expected.not_to have_pagination }

#   scenario "visiting the directory has all reps paginated" do
#     expect(subject.number_of_visible_reps).to eq per_page
#   end

#   scenario "scrolling to the bottom appends the next page of reps", :js do
#     subject.scroll_to_bottom_of_page
#     subject.wait_for_ajax
#     expect(subject.number_of_visible_reps).to eq(per_page * 2)
#   end

#   scenario "sorting reps and scrolling to the bottom keeps them sorted", :js do
#     select("Alphabetically", from: "Sort")
#     expect(subject).to have_content("Balki")
#     expect(subject).not_to have_content("Keyser")
#     subject.scroll_to_bottom_of_page
#     expect(subject).to have_content("Balki")
#     expect(subject).to have_content("Keyser")
#     expect(subject).not_to have_content("Söze")
#     subject.scroll_to_bottom_of_page
#     expect(subject).to have_content("Söze")
#   end

#   scenario "fewer reps than the per page limit provides no pagination", :js do
#     subject.search_for("Keyser")
#     subject.scroll_to_bottom_of_page
#     expect(subject).not_to have_pagination
#   end
# end

