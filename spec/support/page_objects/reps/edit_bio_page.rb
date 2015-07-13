require "support/page_objects/reps/edit_profile_page"

module Reps
  class EditBioPage < EditProfilePage
    def click_edit_bio_button
      click_button "Edit Bio"
    end

    def fill_in_new_bio
      fill_in "biography", with: "Newly updated bio"
      fill_in "government_role", with: "Sultan"
      select "Out Of Office", from: "rep_status"
      select "Green", from: "rep_party"
      select "Utah", from: "rep_state"
    end

    def click_save_bio_button
      click_button "Save Bio"
    end

    def click_cancel_bio_button
      within "[data-role=biography_container]" do
        click_button "Cancel"
      end
    end

    def has_original_bio?
      find("#short_bio").text == "original bio"
    end

    def has_new_bio_data?
      within "[data-role=biography_container]" do
        has_content? "Newly updated bio"
        has_content? "Out Of Office"
        has_content? "Sultan"
        has_content? "Green"
        has_content? "UT"
      end
    end
  end
end

