require "support/page_objects/page"

class PrivacySettingsModal < Page
  def display
    click_button "Edit Privacy"
  end

  def activate_display_stances
  end

  def visible?
    page.has_selector?("#edit_privacy", visible: true)
  end
end

