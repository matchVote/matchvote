require "rails_helper"

describe DirectoryPresenter do
  let(:representatives) { (1..10).map { build(:representative) } }
  subject { described_class }

  before(:each) do
    allow(RepSorter).to receive(:send).and_return(representatives)
  end

  describe "#reps" do
    it "returns all reps, each wrapped in a presenter" do
      expect(subject.new.reps.size).to eq representatives.size
    end
  end

  describe "#present" do
    it "wraps all given reps in their own presenter" do
      reps = subject.new.present(representatives)
      expect(reps.map(&:class).uniq.first).to eq RepresentativePresenter
    end
  end
end

