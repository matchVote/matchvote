require "support/page_objects/page"

class EditRepProfilePage < Page
  attr_reader :rep

  def initialize(user, rep)
    @rep = rep
    super(user)
  end

  def signin_and_visit_rep_profile
    sign_in
    visit_profile
  end

  def visit
    page.visit edit_representative_path(rep)
  end

  def visit_profile
    page.visit rep_path(rep.slug)
  end

  def visit_another_rep_page(rep)
    page.visit rep_path(rep.slug)
  end

  def has_edit_button?
    has_link? "Edit"
  end

  def editable?
    has_css? "body.representatives.edit"
  end
end

