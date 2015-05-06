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
    scenario "clicking Save Stance creates a stance" do
      within("#statement_#{Statement.first.id}") do
        select("Agree", from: "Agreeance")
        select("Somewhat Important", from: "Importance")
        find(".save_btn").click
      end
      expect(user.stances.count).to eq 1
    end
  end
end
