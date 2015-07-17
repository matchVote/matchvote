require "support/page_objects/page"

class CitizenIndexPage < Page
  def signin_and_visit
    sign_in
    visit
  end

  def visit
    page.visit citizens_path
  end

  def visible?
    has_css? "body.citizens.index"
  end
end

