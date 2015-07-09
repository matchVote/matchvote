require "support/page_objects/page"

class EditRepProfilePage < Page
  attr_reader :rep

  def initialize(user, rep)
    @rep = rep
    super(user)
  end

  def signin_and_visit
    sign_in
    visit_profile
    click_link "Edit"
  end

  def visit
    page.visit edit_representative_path(rep)
  end

  alias_method :refresh, :visit

  def visit_profile
    page.visit rep_path(rep.slug)
  end

  def click_edit_demographics_button
    find("[data-behavior=edit_demographics]").click
  end

  def select_gender(gender)
    within "#demographics" do
      select gender, from: "gender"
    end
  end

  def cancel_demographics_edit
    find("[data-behavior=cancel_demographics]").click
  end

  def editable?
    has_css? "body.representatives.edit"
  end

  def has_original_demographics_data?
    within "#demographics" do
      has_select? "gender", selected: "Male"
    end
  end
end

