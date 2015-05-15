require "rails_helper"

feature "Editing a user's stances" do
  given(:user) { create(:user) }
  subject { page }

  background do
    login_as(user, scope: :user)
    visit edit_user_registration_path(user)
  end

  it { is_expected.to have_content("Edit Stances") }
end

