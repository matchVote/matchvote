require "rails_helper"
require "support/page_objects/reps/edit_bio_page"

feature "Editing Representative bio data" do
  given(:profile) { Reps::EditBioPage.new(rep_admin, rep) }
  given(:rep) { create(:representative) }
  given(:rep_admin) { create(:rep_admin, profile_id: rep.id) }

  background do
    profile.signin_and_visit
  end

  scenario "clicking the save bio button updates bio data", :js do
    profile.click_edit_bio_button
    profile.fill_in_new_bio
    profile.click_save_bio_button
    profile.wait_for_ajax
    expect(rep.reload.biography).to match /Newly updated bio/
  end

  scenario "clicking the cancel bio button reverts changes", :js do
    profile.click_edit_bio_button
    profile.fill_in_new_bio
    profile.click_cancel_bio_button
    expect(profile.bio_text_area).not_to match /Newly updated bio/
  end
end

