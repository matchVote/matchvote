require "rails_helper"
require "support/stances"
require "#{Rails.root}/lib/hopper_loader"

feature "Creating stances to issue category statements" do
  given(:user) { create(:user) }
  given(:statement) { Statement.first }
  subject { page }

  background do
    create_statements
    login_as(user, scope: :user)
    visit stances_path
  end

  it { is_expected.to have_css(".stance_card") }
  it { is_expected.to have_content("Neutral") }
  it { is_expected.to have_content("Very Strongly Disagree") }
  it { is_expected.to have_content("Very Important") }
  it { is_expected.to have_content("Foreign Policy") }
  it { is_expected.to have_content("Abortion") }

  scenario "it shows default select box values for statement" do
    agreeance = "#agreeance_#{statement.id}"
    importance = "#importance_#{statement.id}"
    expect(find(agreeance).value).to eq "0"
    expect(find(importance).value).to eq "1"
  end

  scenario "clicking Save Stance creates a stance and logs the event", :js do
    statement_context = "[data-statement-id='#{statement.id}']"
    within statement_context do
      click_button "Save Stance"
      wait_for_ajax
      expect(user.stances.count).to eq 1
      expect(Stance.count).to be > 0
      expect(StanceEvent.count).to eq 1
    end
  end

  context "after saving a stance without refreshing", :js do
    background do
      @statement_context = "[data-statement-id='#{statement.id}']"
      within @statement_context do
        click_button "Save Stance"
        wait_for_ajax
      end
    end

    scenario "clicking Update works" do
      within @statement_context do
        select "Strongly Disagree", from: "Agreeance"
        click_button "Update"
        wait_for_ajax
        expect(Stance.first.agreeance_value_string).to eq "Strongly Disagree"
      end
    end

    scenario "clicking Clear works" do
      within @statement_context do
        select "Strongly Disagree", from: "Agreeance"
        click_button "Update"
        wait_for_ajax
        expect(Stance.first.agreeance_value_string).to eq "Strongly Disagree"
      end
    end
  end
end

