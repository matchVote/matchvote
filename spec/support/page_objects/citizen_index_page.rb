require "support/page_objects/page"

class CitizenIndexPage < Page
  attr_reader :user

  def initialize(user)
    @user = user
  end

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

