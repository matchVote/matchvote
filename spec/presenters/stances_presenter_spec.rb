require "rails_helper"
require "support/stances"

describe StancesPresenter do
  let(:user) { create(:user) }
  let(:issues) { build_issues }
  let(:statements) { build_statements(issues) }
  let(:stances) { statements.map { |statement| build_stance(statement, user) } }

  subject { described_class.new(stances) }

  describe "#issues" do
    it "returns the issue categories for the given stances" do
      expect(subject.issues).to eq issues
    end
  end

  describe "#stances_for_issue" do
    it "returns the subset of stances for the given issue" do
      results = stances.select { |stance| stance.issue_category == issues.first }
      expect(subject.stances_for_issue(issues.first)).to eq results
    end
  end

  describe "#has_stances?" do
    it "returns true if stances exist" do
      expect(subject.has_stances?).to eq true
      expect(described_class.new([]).has_stances?).to be false
    end
  end
end

