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

  scenario "Personal info gets saved for user" do
    signup_page.fill_in_personal_info
    signup_page.create_account

    personal_info = User.first.personal_info
    expect(personal_info["first_name"]).to eq "Hey"
    expect(personal_info["last_name"]).to eq "Bob"
    expect(personal_info["gender"]).to eq "male"
    expect(personal_info["ethnicity"]).to eq "mixed"
    expect(personal_info["party"]).to eq "green"
    expect(personal_info["religion"]).to eq "hindu"
    expect(personal_info["relationship"]).to eq "married"
    expect(personal_info["education"]).to eq "some_college"
    expect(personal_info["birthday"]).to eq "11/12/1492"
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

  scenario "profile pic is saved to AWS" do
    signup_page.choose_file_to_upload
    signup_page.create_account
    user = User.first
    aws_file_regex = /uploads\/user\/profile_pic\/#{user.id}\/test.jpg/
    expect(user.profile_pic_url).to match aws_file_regex
  end
end

