require "support/page_objects/page"

class LayoutHeader < Page
  def click_profile_link
    click_link "view_profile_link"
  end

  def citizen_profile?
    has_css? "body.citizens.show"
  end

  def rep_profile?
    has_css? "body.representatives.show"
  end
end

