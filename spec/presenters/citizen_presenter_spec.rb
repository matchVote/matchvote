require "rails_helper"

describe CitizenPresenter do
  let(:user) { build(:user_with_address) }
  subject { described_class }

  describe "#name" do
    context "when user has no personal info" do
      it "displays username" do
        user = build(:user, personal_info: nil)
        expect(subject.new(user).name).to eq "bob"
      end
    end

    context "when user has first or last name" do
      it "displays the full name" do
        expect(subject.new(user).name).to eq "Bob Jenkins"
      end
    end
  end

  describe "#subtitle" do
    it "returns empty string when user's state is blank" do
      user = build(:user)
      expect(subject.new(user).subtitle).to be_blank
    end

    context "when user's state is present" do
      it "returns 'Voter from ND' when party is blank" do
        user.personal_info = nil
        expect(subject.new(user).subtitle).to eq "Voter from ND"
      end

      it "returns 'Green Voter from ND' when party is present" do
        expect(subject.new(user).subtitle).to eq "Green Voter from ND"
      end
    end
  end
end

