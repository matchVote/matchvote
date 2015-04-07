require "rails_helper"

describe DirectoryPresenter do
  let(:representatives) { (1..10).map { build(:representative) } }
  subject { described_class.new }

  before(:each) do
    allow(subject).to receive(:search_reps).and_return(representatives)
    allow(subject).to receive(:sort_reps).and_return(representatives)
  end

  describe "#reps" do
    context "when no search_name is given" do
      it "returns all reps" do
        expect(subject.reps.size).to eq representatives.size
      end
    end
  end

  describe "#present" do
    it "wraps all given reps in their own presenter" do
      reps = subject.present(representatives)
      expect(reps.map(&:class).uniq.first).to eq RepresentativePresenter
    end
  end
end

