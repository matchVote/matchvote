require "rails_helper"
require "support/authentication"
require "support/page_objects/profile_page"
require "support/stances"

feature "Viewing Citizen profile" do
  given(:user) { create(:user) }
  given(:profile) { ProfilePage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  it { is_expected.to have_content user.username }
  it { is_expected.to have_content "Bob Jenkins" }
  it { is_expected.to have_content "hey there" }
  it { is_expected.to have_content "Green Voter from ND" }

  scenario "shows user's stances" do
    create_one_stance(agreeance: 3, importance: 2)
    profile.refresh
    expect(page).to have_content "blah blah"
    expect(page).to have_content "Very Strongly Agree"
    expect(page).to have_content "Neutral"
  end

  scenario "shows uploaded profile pic if user has one" do
    file = File.open("#{Rails.root}/spec/support/images/test.jpg")
    user.update(profile_pic: file)
    profile.refresh
    expect(profile).to have_aws_url_for_profile_pic
  end

  scenario "shows default profile pic if user doesn't have one" do
    expect(profile.profile_pic_url).to eq "/assets/default.png"
  end

  context "when profile belongs to user" do
    background do
      user.save
    end

    scenario "the edit profile link is visible and works" do
      expect(profile).to have_edit_profile_link
      profile.click_edit_profile_link
      expect(current_path).to eq profile.edit_path
      expect(profile.editing?).to eq true
    end

    scenario "the edit privacy link is visible and works" do
      skip "Privacy settings modal"
      expect(profile).to have_edit_privacy_link
      profile.click_edit_privacy_link
    end

    scenario "the edit stances link is visible and works" do
      expect(profile).to have_edit_stances_link
      profile.click_edit_stances_link
      expect(profile.editing?).to eq true
    end
  end

  context "when profile does not belong to user" do
    given(:new_user) do
      create(:user, username: "jerry", personal_info: { first_name: "Jerry" })
    end

    scenario "edit buttons are not visible" do
      new_user.save
      visit citizen_path(new_user)
      expect(profile).not_to have_edit_profile_link
      expect(profile).not_to have_edit_privacy_link
      expect(profile).not_to have_edit_stances_link
    end
  end
end

