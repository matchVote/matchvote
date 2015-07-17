require "support/page_objects/page"

module Reps
  class ProfilePage < Page
    include ActionView::Helpers

    attr_reader :rep

    def initialize(user, rep)
      @rep = rep
      super(user)
    end

    def signin_and_visit
      sign_in
      visit
    end

    def visit
      page.visit rep_path(rep.slug)
    end

    alias_method :refresh, :visit

    def visit_another_rep_page(rep)
      page.visit rep_path(rep.slug)
    end

    def expand_bio
      click_button "Read Full Bio"
    end

    def has_rep_name?
      has_content? "Borky Buffet"
    end

    def has_rep_birthday?
      has_content? "March 8, 1967"
    end

    def has_contact_address?
      address = rep.contact.postal_addresses.first
      has_content? "#{address.line1}"
      has_content? "#{address.city}, #{address.state} #{address.zip}"
    end

    def has_truncated_bio?
      has_content? truncate(rep.biography, length: 550)
    end

    def has_edit_button?
      has_link? "Edit"
    end

    def has_short_bio?
      has_selector?("#short_bio", visible: true)
    end

    def has_full_bio?
      has_selector?("#full_bio", visible: true)
    end
  end
end

