require "rails_helper"
require "support/authentication"
require "support/page_objects/sign_up_page"

feature "Creating a new account with optional info" do
  given(:signup_page) { SignUpPage.new }
  subject { page }

  background do
    signup_page.visit
    signup_page.use_default_account_info
  end

  feature "Filling in personal info" do
  end

  scenario "Contact info gets saved for user" do
    signup_page.fill_in_contact_info
    signup_page.create_account

    user = User.first
    expect(user.contact.phone_numbers).to include "1234567890"
  end
end

