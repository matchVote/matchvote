require "rails_helper"
require "support/helpers/stance_helper"

describe MatchCalculator do
  let(:helper) { StanceHelper.new }
  let(:citizen) { build(:user) }
  let(:rep) { build(:representative) }
  subject { described_class }

  before(:each) do
    values = {
      one: [ {agreeance_value:  1, importance_value: 3},
             {agreeance_value: -1, importance_value: 0},
             {agreeance_value: -2, importance_value: 2} ],
      two: [ {agreeance_value:  1, importance_value: 1},
             {agreeance_value: -1, importance_value: 4},
             {agreeance_value:  3, importance_value: 4} ]
    }
    helper.create_stances_for(citizen, rep, values)
  end

  describe "#overall_percent" do
    it "finds overall percent of matching stances" do
      expect(subject.new(citizen, rep).overall_percent.round(2)).to eq 0.75
    end

    it "returns 0 if NaN" do
      expect(subject.new(build(:user), rep).overall_percent).to eq 0
    end
  end
end

