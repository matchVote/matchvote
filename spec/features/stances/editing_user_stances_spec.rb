require "rails_helper"
require "support/stances"
require "support/wait_for_ajax"

feature "Editing a user's stances" do
  given(:user) { create(:user) }
  subject { page }

  background do
    create_statements
    login_as(user, scope: :user)
    visit edit_user_registration_path(user)
  end

  it { is_expected.to have_content("Edit Stances") }

  context "without any stances" do
    it { is_expected.to have_content("You have no stances to edit.") }
  end

  context "when user has stances" do
    background do
      create_stances(user)
      visit edit_user_registration_path(user)
    end

    scenario "lists all stance issues" do
      expect(subject).to have_content("Foreign Policy")
      expect(subject).to have_content("Abortion")
    end

    scenario "list all stances" do
      expect(subject).to have_content("Foreign policy statement 1")
      expect(subject).to have_content("Foreign policy statement 2")
      expect(subject).to have_content("Abortion statement 1")
      expect(subject).to have_content("Abortion statement 2")
    end

    scenario "clicking Update Stance updates the stance", js: true do
      stance = Stance.first
      within "#stance[data-stance-id='#{stance.id}']" do
        select "Very Strongly Disagree", from: "Agreeance"
        select "Extremely Important", from: "Importance"
        click_button "Update Stance"
      end

      wait_for_ajax
      expect(stance.reload.agreeance_value).to eq "Very Strongly Disagree"
      expect(stance.reload.importance_value).to eq "Extremely Important"
    end
  end
end

