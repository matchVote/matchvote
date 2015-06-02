require "rails_helper"
require "support/page_objects/edit_account_page"

feature "Editing account settings" do
  given(:user) { create(:user) }
  given(:profile) { EditAccountPage.new(user) }
  subject { page }

  background do
    profile.visit
  end

  it { is_expected.to have_content("Email & Password") }
  it { is_expected.to have_field("user_email") }
  it { is_expected.to have_field("Current password") }

  feature "changing user email" do
    scenario "successfully updates email with valid input" do
      new_email = "new_email@foo.com"
      profile.update_account_info email: new_email, password: user.password
      expect(user.reload.email).to eq new_email
    end

    scenario "does not update email with invalid input" do
      profile.update_account_info email: nil, password: user.password
      expect(subject).to have_content("Email can't be blank")
    end
  end

  feature "changing user password" do
    given(:options) do
      { email: user.email, password: user.password, new_password: "@123!123" }
    end

    scenario "successfully updates password with valid input" do
      profile.update_account_info(options)
      expect(subject).to have_content("Your account has been updated successfully")
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

