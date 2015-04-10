require "rails_helper"
require "support/authentication"

feature "Edit Representative profile" do
  given(:user) { create(:user, admin: true) }
  subject { page }

  background do
    sign_in(user)
    visit rep_path(rep.slug)
  end
end
