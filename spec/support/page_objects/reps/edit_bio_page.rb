require "support/page_objects/reps/edit_profile_page"

module Reps
  class EditBioPage < EditProfilePage
    def click_edit_bio_button
      click_button "Edit Bio"
    end

    def fill_in_new_bio
      fill_in "biography", with: "Newly updated bio"
    end

    def click_save_bio_button
      click_button "Save Bio"
    end

    def click_cancel_bio_button
      within "[data-role=biography_container]" do
        click_button "Cancel"
      end
    end

    def bio_text_area
      find("[data-role=biography_text_area]").value
    end
  end
end

