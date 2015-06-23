require "rails_helper"
require "support/helpers/stance_helper"

describe MatchCalculator do
  let(:helper) { StanceHelper.new }
  let(:citizen) { build(:user) }
  let(:rep) { build(:representative) }
  subject { described_class }

  before(:each) do
    statements = helper.build_statements(helper.build_issues)

    create(:stance, statement: statements.first, opinionable: citizen,
           agreeance_value: 1, importance_value: 3)
    create(:stance, statement: statements.first, opinionable: rep,
           agreeance_value: 1, importance_value: 1)

    create(:stance, statement: statements[1], opinionable: citizen,
           agreeance_value: -1, importance_value: 0)
    create(:stance, statement: statements[1], opinionable: rep,
           agreeance_value: -1, importance_value: 4)

    create(:stance, statement: statements.last, opinionable: citizen,
           agreeance_value: -2, importance_value: 2)
    create(:stance, statement: statements.last, opinionable: rep,
           agreeance_value: 3, importance_value: 4)
  end

  describe "#overall_percent" do
    it "finds overall percent of matching stances" do
      expect(subject.new(citizen, rep).overall_percent.round(2)).to eq 0.75
    end
  end
end

