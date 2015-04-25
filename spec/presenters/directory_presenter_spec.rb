require "rails_helper"

describe DirectoryPresenter do
  let(:representatives) do
    (1..10).map { build(:representative) }
  end

  describe "#reps" do
    context "when no sort_by is given" do
      it "sorts reps by popularity" do
        reps = [build(:representatives, name_recognition: 100),
                build(:representatives, name_recognition: 10),
                build(:representatives, name_recognition: 88)]
        presenter = described_class.new(reps)
        expect(presenter.reps.map(&:name_recognition)).to eq [100, 88, 10]
      end
    end
  end

  describe "#present" do
    it "wraps all given reps in their own presenter" do
      reps = described_class.new.present(representatives)
      expect(reps.map(&:class).uniq.first).to eq RepresentativePresenter
    end
  end
end

