require "rails_helper"
require "support/authentication"

feature "Signing out of a valid session" do
  given(:user) { create(:user) }
  subject { page }

  background do
    visit root_path
    sign_in_with email: user.email, password: user.password
    find(:xpath, "//a[@href='#{destroy_user_session_path}']").click
  end

  it { is_expected.not_to have_selector("//a[@href='#{destroy_user_session_path}']") }
  it { is_expected.to have_button("Sign In") }
end

