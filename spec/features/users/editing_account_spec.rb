require "rails_helper"
require "support/authentication"

feature "Editing a user account" do
  given(:user) { create(:user) }
  subject { page }

  background do
    sign_in(user)
    visit edit_user_registration_path(user)
  end
end

