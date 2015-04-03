require "rails_helper"

describe DirectoryPresenter do
  let(:representatives) { (1..10).map { build(:representative) } }
  subject { described_class }

  before(:each) do
    allow(RepSorter).to receive(:send).and_return(representatives)
  end

  describe "#all_reps" do
    it "returns all reps, each wrapped in a presenter" do
      reps = subject.new.all_reps
      expect(reps.size).to eq representatives.size
      expect(reps.map(&:class).uniq.first).to eq RepresentativePresenter
    end
  end
end

