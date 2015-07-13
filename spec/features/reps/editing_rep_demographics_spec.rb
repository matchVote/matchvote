require "rails_helper"
require "support/page_objects/reps/edit_demographics_page"

feature "Editing Representative demographics" do
  given(:profile) { Reps::EditDemographicsPage.new(rep_admin, rep) }
  given(:rep) { create(:representative) }
  given(:rep_admin) { create(:rep_admin, profile_id: rep.id) }

  background do
    profile.signin_and_visit
    profile.click_edit_button
  end

  scenario "clicking Cancel resets data", :js do
    expect(profile).to have_editable_demographics
    profile.update_demographics
    profile.click_cancel_button
    expect(profile).to have_original_data
    expect(profile).not_to have_editable_demographics
  end

  scenario "clicking Save updates data", :js do
    profile.update_demographics
    profile.click_save_button
    expect(profile).to have_new_data
    expect(profile).not_to have_editable_demographics
  end
end

