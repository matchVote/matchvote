require "rails_helper"
require "support/page_objects/reps/edit_demographics_page"

feature "Editing Representative demographics" do
  given(:profile) { Reps::EditDemographicsPage.new(user, rep) }
  given(:rep) { create(:representative) }
  given(:user) do
    create(:user, rep_admin: true, profile_type: :Representative, profile_id: rep.id)
  end

  background do
    profile.signin_and_visit
    profile.click_edit_demographics_button
  end

  scenario "clicking Cancel resets data", :js do
    expect(profile).to have_editable_demographics
    profile.select_gender("Female")
    profile.cancel_demographics_edit
    expect(profile).to have_original_demographics_data
    expect(profile).not_to have_editable_demographics
  end
end

