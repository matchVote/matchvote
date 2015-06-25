require "rails_helper"
require "support/helpers/stance_helper"

describe MatchCalculator do
  let(:helper) { StanceHelper.new }
  let(:citizen) { build(:user) }
  let(:rep) { build(:representative) }
  subject { described_class }

  before(:each) do
    # [[agreeance, importance], ...]
    values = { one: [[1, 3], [-1, 0], [0, 1], [-2, 2]],
               two: [[1, 1], [-1, 4], [0, 3], [ 3, 4]] }
    helper.create_stances_for(citizen, rep, values)
  end

  describe "#overall_percent" do
    it "finds overall percent of matching stances" do
      expect(subject.new(citizen, rep).overall_percent.round(2)).to eq 0.82
    end

    it "returns 0 if NaN" do
      expect(subject.new(build(:user), rep).overall_percent).to eq 0
    end
  end
end

