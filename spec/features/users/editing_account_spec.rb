require "rails_helper"
require "support/page_objects/edit_profile_page"

feature "Editing account settings" do
  given(:user) { create(:user) }
  given(:profile) { EditProfilePage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  it { is_expected.to have_content("Email & Password") }
  it { is_expected.to have_field("user_email") }
  it { is_expected.to have_field("Current password") }

  feature "changing user email" do
    context "with valid input" do
      given(:new_email) { "new_email@foo.com"}

      scenario "successfully updates email" do
        profile.update_account_info email: new_email, password: user.password
        expect(user.reload.email).to eq new_email
      end
    end

    context "with invalid input" do
      scenario "does not update email" do
        profile.update_account_info email: nil, password: user.password
        expect(subject).to have_content("Email can't be blank")
      end
    end
  end

  feature "changing user password" do
    given(:options) do
      { email: user.email, password: user.password, new_password: "@123!123" }
    end

    context "with valid input" do
      scenario "successfully updates password" do
        profile.update_account_info(options)
        expect(subject).to have_content("Your account has been updated successfully")
      end
    end

    context "with invalid input" do
      scenario "does not update invalid password" do
        options[:new_password] = options[:confirm] = "8d"
        profile.update_account_info(options)
        expect(subject).to have_content("Password is too short")
      end

      scenario "does not update missing confirmation" do
        options[:confirm] = ""
        profile.update_account_info(options)
        expect(subject).to have_content("confirmation doesn't match")
      end
    end
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
      profile.click_update_button("pic_and_username")
      expect(profile).to have_aws_url_for_profile_pic
    end
  end

  feature "cancelling account" do
    scenario "deletes user record" do
      expect { click_button "Cancel Account" }.to change(User, :count).by(-1)
    end

    scenario "redirects back to home page" do
      click_button "Cancel Account"
      expect(subject).to have_content("Create Account")
    end
  end
end


