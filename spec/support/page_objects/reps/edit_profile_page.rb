require "support/page_objects/page"

module Reps
  class EditProfilePage < Page
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

    def editable?
      has_css? "body.representatives.edit"
    end
  end
end

