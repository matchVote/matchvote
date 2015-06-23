require "support/page_objects/page"

class DirectoryPage < Page
  def signin_and_visit
    sign_in
    visit
  end

  def visit
    page.visit root_path
  end
end

