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

    contact = User.first.contact
    expect(contact.phone_numbers).to eq ["1234567890"]
    expect(contact.external_ids).to include "twitter" => "my_twitter_name"

    address = contact.postal_addresses.first
    expect(address.line1).to eq "1 Boweevil Lane"
    expect(address.city).to eq "Meat Camp"
    expect(address.state).to eq "NC"
    expect(address.zip).to eq "12345"
  end
end

