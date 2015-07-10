require "rails_helper"
require "support/page_objects/reps/edit_profile_page"

feature "Edit Representative profile" do
  given(:profile) { Reps::EditProfilePage.new(user, rep) }
  given(:rep) { create(:representative) }
  given(:user) do
    create(:user, rep_admin: true, profile_type: :Representative, profile_id: rep.id)
  end

  subject { profile }

  background do
    profile.signin_and_visit
  end

  it { is_expected.to be_editable }

  context "when user is not authorized to edit the rep" do
    scenario "requesting the edit url directly redirects to the root url" do
      profile.user.update(rep_admin: false, admin: false)
      profile.refresh
      expect(current_url).to eq root_url
    end
  end
end

