require "rails_helper"
require "support/page_objects/edit_rep_profile_page"

feature "Edit Representative profile" do
  given(:profile) { EditRepProfilePage.new(user, rep) }
  given(:rep) { create(:representative) }
  given(:user) do
    create(:user, rep_admin: true, profile_type: :Representative, profile_id: rep.id)
  end

  background do
    profile.signin_and_visit
  end

  feature "Updating demographics" do
    background do
      profile.click_edit_demographics_button
    end

    scenario "displays existing data", :js do
      expect(profile).to have_original_demographics_data
    end

    scenario "clicking Cancel resets data", :js do
      profile.select_gender("Female")
      profile.cancel_demographics_edit
      expect(profile).to have_original_demographics_data
    end
  end
end

