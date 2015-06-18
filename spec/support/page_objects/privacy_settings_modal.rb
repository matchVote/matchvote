require "support/page_objects/page"

class PrivacySettingsModal < Page
  def display_modal
    click_button "Edit Privacy"
  end

  def check_display_all_stances
    check("display_all_stances")
  end

  def uncheck_display_all_stances
    uncheck("display_all_stances")
  end

  def save_changes
    within "#edit_privacy" do
      click_button "Save Changes"
    end
    wait_for_ajax
  end

  def visible?
    page.has_selector?("#edit_privacy", visible: true)
  end

  def is_checked?(name)
    find("##{name}").checked?
  end
end

