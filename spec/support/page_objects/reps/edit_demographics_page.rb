require "support/page_objects/reps/edit_profile_page"

module Reps
  class EditDemographicsPage < EditProfilePage
    def click_edit_button
      find("[data-behavior=edit_demographics]").click
    end

    def click_cancel_button
      find("[data-behavior=cancel_demographics]").click
    end

    def click_save_button
      find("[data-behavior=save_demographics]").click
    end


    def update_demographics
      within "#demographics" do
        select "Female", from: "gender"
        select "Hindu", from: "religion"
        select "Gay", from: "orientation"
        fill_in "date_picker", with: "12/02/1934"
      end
    end

    def has_editable_demographics?
      within "#demographics" do
        has_select? "gender"
      end
    end

    def has_original_data?
      within "#demographics" do
        has_content? "Male"
      end
    end

    def has_new_data?
      within "#demographics" do
        has_content? "Female"
        has_content? "Hindu"
        has_content? "Gay"
        has_content? "December 2, 1934"
      end
    end
  end
end

