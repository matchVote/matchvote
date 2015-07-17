require "rails_helper"
require "support/page_objects/reps/edit_bio_page"

feature "Editing Representative bio data" do
  given(:profile) { Reps::EditBioPage.new(rep_admin, rep) }
  given(:rep) { create(:representative, biography: "original bio") }
  given(:rep_admin) { create(:rep_admin, profile_id: rep.id) }

  background do
    profile.signin_and_visit
  end

  scenario "clicking the save bio button updates bio data", :js do
    profile.click_edit_bio_button
    profile.fill_in_new_bio
    profile.click_save_bio_button
    profile.wait_for_ajax
    expect(profile).to have_new_bio_data
    rep.reload
    expect(rep.biography).to match /Newly updated bio/
    expect(rep.status).to eq "out_of_office"
    expect(rep.government_role).to eq "Sultan"
    expect(rep.party).to eq "green"
    expect(rep.state).to eq "UT"
  end

  scenario "clicking the cancel bio button reverts changes", :js do
    profile.click_edit_bio_button
    profile.fill_in_new_bio
    profile.click_cancel_bio_button
    expect(profile).to have_original_bio
  end
end

