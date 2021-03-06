require "rails_helper"
require "support/helpers/stance_helper"

describe MatchCalculator do
  let(:helper) { StanceHelper.new }
  let(:citizen) { build(:user) }
  let(:rep) { build(:representative) }
  let(:statements) { helper.build_statements }
  subject { described_class }

  before(:each) do
    citizen_stances = [[1, 2], [-1, 0], [0, 1], [-2, 2]]
    rep_stances =     [[1, 0], [-1, 2], [0, 2], [ 3, 2]]
    helper.create_stances_for(statements, citizen, citizen_stances)
    helper.create_stances_for(statements, rep, rep_stances)
  end

  describe "#overall_percent" do
    it "finds overall percent of matching stances" do
      percent = subject.new(citizen.stances, rep.stances).overall_percent.round(2)
      expect(percent).to eq 0.79
    end

    it "returns 0 if NaN" do
      percent = subject.new(build(:user).stances, rep.stances).overall_percent
      expect(percent).to eq 0
    end
  end
end

