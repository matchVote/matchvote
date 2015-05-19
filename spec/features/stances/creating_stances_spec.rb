require "rails_helper"
require "support/stances"
require "#{Rails.root}/lib/hopper_loader"

feature "Responding to issue category statements" do
  given(:user) { create(:user) }
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

  context "when a stance does not exist" do
    let(:statement) { Statement.first }

    scenario "it shows default select box values for statement" do
      agreeance = "#agreeance_#{statement.id}"
      importance = "#importance_#{statement.id}"
      expect(find(agreeance).value).to eq "0"
      expect(find(importance).value).to eq "2"
    end

    scenario "clicking Save Stance creates a stance", js: true do
      statement_context = "[data-statement-id='#{statement.id}']"
      within statement_context do
        click_button "Save Stance"
        wait_for_ajax
        expect(user.stances.count).to eq 1
        expect(Stance.count).to be > 0
      end
    end
  end

  context "when a stance does exist" do
    background do
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
      expect(find(importance).value).to eq "4"
    end

    scenario "clicking Update Stance updates the stance", js: true do
      within @statement_context do
        select "Strongly Disagree", from: "Agreeance"
        select "Not Very Important", from: "Importance"
        click_button "Update Stance"
        wait_for_ajax
        expect(@stance.reload.agreeance_value_string).to eq "Strongly Disagree"
        expect(@stance.reload.importance_value_string).to eq "Not Very Important"
      end
    end
  end
end

