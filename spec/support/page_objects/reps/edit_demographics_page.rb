require "support/page_objects/reps/edit_profile_page"

module Reps
  class EditDemographicsPage < EditProfilePage
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

    def has_editable_demographics?
      within "#demographics" do
        has_select? "gender", selected: "Male"
      end
    end

    def has_original_demographics_data?
      within "#demographics" do
        has_content? "Male"
      end
    end
  end
end

