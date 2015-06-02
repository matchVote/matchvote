require "rails_helper"
require "support/page_objects/edit_profile_page"

feature "Editing Citizen profile" do
  given(:user) { create(:user) }
  given(:profile) { EditProfilePage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  feature "uploading profile pic" do
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

  scenario "if current user does not own profile, it can't be updated" do
    profile.edit_other_profile(create(:user, username: "lloyd"))
    expect(current_url).to eq root_url
  end
end

