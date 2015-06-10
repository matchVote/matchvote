require "rails_helper"
require "support/page_objects/edit_profile_page"

feature "Editing Citizen profile" do
  given(:user) { create(:user) }
  given(:profile) { EditProfilePage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  feature "Updating personal info" do
    scenario "displays existing citizen data" do
      expect(profile).to have_personal_info
    end

    scenario "persists changes for citizen", :js do
      profile.update_personal_info
      wait_for_ajax

      personal_info = User.first.personal_info
      expect(personal_info["first_name"]).to eq "Hey"
      expect(personal_info["last_name"]).to eq "BobbyJoe"
      expect(personal_info["gender"]).to eq "male"
      expect(personal_info["ethnicity"]).to eq "mixed"
      expect(personal_info["party"]).to eq "democrat"
      expect(personal_info["religion"]).to eq "hindu"
      expect(personal_info["relationship"]).to eq "married"
      expect(personal_info["education"]).to eq "some_college"
      expect(personal_info["birthday"]).to eq "11/12/1492"
      expect(personal_info["bio"]).to eq "Nice bio"
    end
  end
end

