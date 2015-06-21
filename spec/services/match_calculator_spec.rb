require "rails_helper"
require "support/helpers/stance_helper"

describe MatchCalculator do
  let(:helper) { StanceHelper.new }
  let(:citizen) { build(:user) }
  let(:rep) { build(:representative) }
  subject { described_class }

  describe "#overall_percent" do
    it "finds overall percent of matching stances" do
      helper.create_statements
      expect(subject.new(citizen, rep).overall_percent).to eq 0.67
    end
  end
end

