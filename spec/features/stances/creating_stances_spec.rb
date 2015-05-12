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

    scenario "clicking Save Stance creates a stance" do
      pending "Capybara refuses to click button"
      fail
      # statement_id = Statement.first.id
      # find("button[data-statement-id='#{statement_id}']").click
      # expect(user.stances.count).to eq 1
      # expect(Stance.count).to be > 0
    end
  end

  context "when a stance does exist" do
    background do
      @stance = create(:stance, opinionable_id: user.id, opinionable_type: "User")
      visit stances_path
    end

    it { is_expected.to have_selector(".update_btn") }

    scenario "it shows the saved select box values for the stance" do
      agreeance = "#agreeance_#{statement.id}"
      importance = "#importance_#{statement.id}"
      expect(find(agreeance).value).to eq "1"
      expect(find(importance).value).to eq "3"
    end

    scenario "clicking Update Stance updates the stance" do
      statement_id = @stance.statement.id
      select "Agree", from: "agreeance_#{statement_id}"
      find("button[data-statement-id='#{statement_id}']").click
      expect(@stance.reload.agreeance_value).to eq "Agree"
    end
  end
end

