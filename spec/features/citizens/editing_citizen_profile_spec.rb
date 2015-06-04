require "rails_helper"
require "support/page_objects/edit_profile_page"

feature "Editing Citizen profile" do
  given(:user) { create(:user) }
  given(:profile) { EditProfilePage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  scenario "if current user does not own profile, it can't be updated" do
    profile.edit_other_profile(create(:user, username: "lloyd"))
    expect(current_url).to eq root_url
  end

  feature "Uploading profile pic" do
    scenario "shows default picture if user has none" do
      expect(profile).to have_default_pic
    end

    scenario "shows profile pic if user has one" do
      file = File.open("#{Rails.root}/spec/support/images/test.jpg")
      user.update(profile_pic: file)
      profile.refresh
      expect(profile).to have_aws_url_for_profile_pic
    end

    scenario "selecting pic and clicking Update saves pic to AWS" do
      profile.choose_pic_to_upload
      profile.click_update_profile_pic_button
      expect(profile).to have_aws_url_for_profile_pic
    end
  end

  feature "Updating personal info" do
    scenario "displays existing citizen data" do
      expect(profile).to have_personal_info
    end

    scenario "persists changes for citizen" do
      profile.update_personal_info

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

