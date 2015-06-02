require "rails_helper"
require "support/stances"
require "support/page_objects/edit_profile_page"
require "support/wait_for_ajax"

feature "Editing Citizen stances" do
  given(:user) { create(:user) }
  given(:profile) { EditProfilePage.new(user) }
  subject { page }

  background do
    create_statements
    # login_as(user, scope: :user)
    profile.visit
  end

  it { is_expected.to have_content("Edit Saved Stances") }

  context "without any stances" do
    it { is_expected.to have_content("You haven't saved any stances yet.") }
    it { is_expected.to have_link("Click here add your political stances") }
  end

  context "when user has stances" do
    background do |example|
      unless example.metadata[:skip_before]
        create_stances(user)
        profile.refresh
      end
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

    scenario "clicking Update updates the stance", :js do
      stance = Stance.first
      within ".stance[data-stance-id='#{stance.id}']" do
        select "Very Strongly Disagree", from: "Agreeance"
        select "Very Important", from: "Importance"
        click_button "Update"
      end

      wait_for_ajax
      expect(stance.reload.agreeance_value_string).to eq "Very Strongly Disagree"
      expect(stance.reload.importance_value_string).to eq "Very Important"
    end

    scenario "clicking Clear deletes the stance", :js do
      stance = Stance.first
      within ".stance[data-stance-id='#{stance.id}']" do
        click_button "Clear"
        wait_for_ajax
        expect(user.stances.count).to eq 3
      end
      expect(subject).not_to have_content /#{stance.statement.text}/
    end

    scenario "deleting the last stance for an issue removes the issue", 
      :js, :skip_before do
      stance = create_one_stance
      profile.refresh
      within ".stance[data-stance-id='#{stance.id}']" do
        click_button "Clear"
      end

      wait_for_ajax
      expect(subject).not_to have_content("Temp Name")
    end
  end
end

