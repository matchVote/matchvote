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
    profile.click_edit_button
  end

  scenario "clicking Cancel resets data", :js do
    expect(profile).to have_editable_demographics
    profile.select_gender("Female")
    profile.click_cancel_button
    expect(profile).to have_original_data
    expect(profile).not_to have_editable_demographics
  end

  scenario "clicking Save updates data", :js do
    profile.select_gender("Female")
    profile.click_save_button
    expect(profile).to have_new_data
    expect(profile).not_to have_editable_demographics
    expect(rep.reload.gender).to eq "female"
  end
end

