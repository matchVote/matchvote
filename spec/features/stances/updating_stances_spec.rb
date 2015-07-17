require "rails_helper"
require "support/stances"
require "#{Rails.root}/lib/hopper_loader"

feature "Updating and Deleting stances to issue category statements" do
  given(:user) { create(:user) }
  subject { page }

  background do
    create_statements
    login_as(user, scope: :user)
    @stance = create(:stance, opinionable: user)
    @statement = @stance.statement
    @statement_context = "[data-statement-id='#{@statement.id}']"
    visit stances_path
  end

  it { is_expected.to have_selector(".update_btn") }

  scenario "it shows the saved select box values for the stance" do
    agreeance = "#agreeance_#{@statement.id}"
    importance = "#importance_#{@statement.id}"
    expect(find(agreeance).value).to eq "1"
    expect(find(importance).value).to eq "2"
  end

  scenario "clicking Update updates the stance and logs the event", :js do
    within @statement_context do
      select "Strongly Disagree", from: "Agreeance"
      select "Not Very Important", from: "Importance"
      click_button "Update"
      wait_for_ajax
      expect(@stance.reload.agreeance_value_string).to eq "Strongly Disagree"
      expect(@stance.reload.importance_value_string).to eq "Not Very Important"
      expect(StanceEvent.count).to eq 1
    end
  end

  context "after updating a stance without refreshing", :js do
    scenario "clicking Update works" do
      within @statement_context do
        click_button "Update"
        wait_for_ajax

        select "Disagree", from: "Agreeance"
        click_button "Update"
        wait_for_ajax
        expect(@stance.reload.agreeance_value_string).to eq "Disagree"
      end
    end

    scenario "clicking Clear works" do
      within @statement_context do
        click_button "Update"
        wait_for_ajax

        click_button "Clear"
        wait_for_ajax
        expect(user.stances.count).to eq 0
      end
    end
  end

  scenario "clicking Clear deletes the stance and logs the event", :js do
    within @statement_context do
      click_button "Clear"
      wait_for_ajax
      expect(user.stances.count).to eq 0
      expect(StanceEvent.count).to eq 1
    end
  end

  scenario "clicking Clear resets the form", :js do
    within @statement_context do
      click_button "Clear"
      wait_for_ajax
      expect(subject).to have_button "Save Stance"
      expect(subject).not_to have_button "Clear"
      expect(find("#agreeance_#{@statement.id}").value).to eq "0"
      expect(find("#importance_#{@statement.id}").value).to eq "1"
    end
  end

  context "after clearing a stance without refreshing", :js do
    scenario "clicking Save Stance works" do
      within @statement_context do
        click_button "Clear"
        wait_for_ajax
        expect(user.stances.count).to eq 0

        click_button "Save Stance"
        wait_for_ajax
        expect(user.stances.count).to eq 1
      end
    end
  end
end
