require "rails_helper"
require "support/authentication"

feature "Signing out of a valid session" do
  given(:user) { create(:user) }
  subject { page }

  background do
    visit root_path
    sign_in_with email: user.email, password: user.password
    click_link "Sign out"
  end

  it { should_not have_link "Sign out" }
  it { should have_button "Sign In" }
end

