require "rails_helper"

describe RepresentativePresenter do
  let(:current) { Date.parse("4-4-2015") }
  let(:rep)     { build(:representative) }
  let(:user)    { build(:user) }

  subject { described_class }

  describe "#age" do
    it "returns the number of years since the birthdate" do
      allow(Date).to receive(:current).and_return(current)

      rep = build(:representative, birthday: "2000-1-5")
      expect(subject.new(rep).age).to eq 15

      rep = build(:representative, birthday: "2000-05-25")
      expect(subject.new(rep).age).to eq 14
    end
  end

  describe "#react_hash" do
    it "adds more keys to the normal model hash" do
      presenter = subject.new(rep)
      expect(presenter.react_hash.keys).to include(:full_name, :overall_match_percent)
    end
  end
end

