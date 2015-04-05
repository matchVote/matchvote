require "rails_helper"

describe RepresentativePresenter do
  let(:current) { Date.parse("4-4-2015") }
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
end

