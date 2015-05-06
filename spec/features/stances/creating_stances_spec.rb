require "rails_helper"
require "#{Rails.root}/lib/hopper_loader"

feature "Responding to issue category statements" do
  given(:user) { create(:user) }
  subject { page }

  background do
    login_as(user, scope: :user)
    visit stances_path
  end

  it { is_expected.to have_css(".stance_card") }
  it { is_expected.to have_content("Neutral") }
  it { is_expected.to have_content("Very Strongly Disagree") }
  it { is_expected.to have_content("Very Important") }
  it { is_expected.to have_content("Energy") }
  it { is_expected.to have_content("Foreign Policy") }
  it { is_expected.to have_content("Abortion") }

  context "when a stance does not exist" do
    scenario "clicking Save Stance creates a stance" do
      select("Agree", from: "Agreeance")
      select("Somewhat Important", from: "Importance")
      click_button "Save Stance"
      expect(user.stances.count).to eq 1
    end
  end
end
