require "rails_helper"
require "support/authentication"

feature "Editing account settings" do
  given(:user) { create(:user) }
  subject { page }

  background do
    visit root_path
    sign_in_with email: user.email, password: user.password
    visit edit_user_registration_path(user)
  end

  it { should have_content("Email & Password") }
  it { should have_field("user_email") }
  it { should have_field("Current password") }

  feature "changing user email" do
    context "with valid input" do
      given(:new_email) { "new_email@foo.com"}

      scenario "successfully updates email" do
        update_user email: new_email, password: user.password
        expect(user.reload.email).to eq new_email
      end
    end

    context "with invalid input" do
      scenario "does not update email" do
        update_user email: nil, password: user.password
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
        update_user(options)
        expect(subject).to have_content("Your account has been updated successfully")
      end
    end

    context "with invalid input" do
      scenario "does not update invalid password" do
        options[:new_password] = options[:confirm] = "8d"
        update_user(options)
        expect(subject).to have_content("Password is too short")
      end

      scenario "does not update missing confirmation" do
        options[:confirm] = ""
        update_user(options)
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


