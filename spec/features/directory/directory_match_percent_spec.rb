require "rails_helper"
require "support/helpers/stance_helper"
require "support/page_objects/directory_page"

feature "Directory match percentage" do
  given(:user) { create(:user) }
  given(:rep) { create(:representative, slug: "joe-bob") }
  given(:directory) { DirectoryPage.new(user) }
  given(:helper) { StanceHelper.new }

  background do
    # [[agreeance, importance], ...]
    values = { one: [[1, 3], [-1, 0], [-2, 2], [1, 1]],
               two: [[1, 1], [-1, 4], [ 3, 4], [0, 2]] }
    helper.create_stances_for(user, rep, values)
    directory.signin_and_visit
  end

  scenario "shows match percent per rep" do
    within "#joe-bob" do
      expect(directory).to have_content "80%"
    end
  end
end

