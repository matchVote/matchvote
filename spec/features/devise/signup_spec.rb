require "rails_helper"
require "support/authentication"

feature "Signing up for a new account" do
  given(:old_user) { create(:user) }
  subject { page }

  background do
    visit root_path
    click_link "Create Account"
  end

  it { is_expected.to have_content("Join matchVote") }
  it { is_expected.to have_field("Email") }
  it { is_expected.to have_field("Username") }
  it { is_expected.to have_field("Password") }
  it { is_expected.to have_field("Confirm Password") }

  context "with valid input" do
    background do
      signup_with email: "heybob@foobar.com", password: "@123abc!", username: "bob"
    end

    scenario "creates new user and defaults it to a citizen account" do
      expect(User.count).to eq 1
      user = User.first
      expect(user.profile_id).to eq user.id
      expect(user.profile_type).to eq "User"
    end

    scenario "redirects to stances page" do
      expect(current_path).to eq stances_path
    end
  end

  context "with invalid input" do
    scenario "notifies user if the email is absent" do
      signup_with email: nil, password: "@123abc!"
      expect(subject).to have_content("Email can't be blank")
    end

    scenario "notifies user if the email has been used already" do
      signup_with email: old_user.email, password: "@123abc!"
      expect(subject).to have_content("Email has already been taken")
    end

    scenario "notifies user if the password is absent" do
      signup_with email: "what@hey.com", password: nil
      expect(subject).to have_content("Password can't be blank")
    end

    scenario "notifies user if the password confirmation doesn't match" do
      signup_with email: "what@bar.com", password: "@123abc!", confirm: "12341234"
      expect(subject).to have_content("Password confirmation doesn't match")
    end

    scenario "notifies user if username is absent" do
      signup_with email: "heybob@foobar.com", password: "@123abc!", username: nil
      expect(subject).to have_content("Username can't be blank")
    end
  end
end

