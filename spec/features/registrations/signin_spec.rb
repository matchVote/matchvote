require "rails_helper"
require "support/page_objects/sign_in_page"
require "support/page_objects/profile_page"

feature "Signing in with an existing account" do
  given(:user) { create(:user_with_pic) }
  subject { SignInPage.new }

  background do
    subject.visit
  end

  it { is_expected.to have_email_field }
  it { is_expected.to have_password_field }

  context "with valid input" do
    scenario "successfully signs in user if email and password are valid" do
      subject.sign_in(email: user.email, password: user.password)
      expect(subject).not_to have_sign_in_button
      expect(ProfilePage.new(user)).to have_aws_url_for_navbar_pic
    end

    scenario "directs user to root page" do
      subject.sign_in(email: user.email, password: user.password)
      expect(current_path).to eq root_path
    end
  end

  scenario "does not login with invalid email or password" do
    subject.sign_in(email: nil, password: user.password)
    expect(current_path).to eq subject.sign_in_path 
    expect(subject).to have_sign_in_button

    subject.sign_in(email: user.email, password: "waht_me_worry?")
    expect(current_path).to eq subject.sign_in_path 
    expect(subject).to have_sign_in_button
  end
end

