require "support/page_objects/page"

class PrivacySettingsModal < Page
  def display_modal
    click_button "Edit Privacy"
  end

  def display_all_stances
    check("display_all_stances")
  end

  def hide_all_stances
    uncheck("display_all_stances")
  end

  def visible?
    page.has_selector?("#edit_privacy", visible: true)
  end

  def has_all_options_checked?
    false
  end

  def has_no_options_checked?
    false
  end
end

