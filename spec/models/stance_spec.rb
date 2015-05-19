require "rails_helper"

describe Stance do
  let(:stance) { build(:stance) }

  describe "#agreeance_value" do
    it "defaults to 0 when stance has no value" do
      stance.agreeance_value = nil
      expect(stance.agreeance_value).to eq 0
    end
  end

  describe "#importance_value" do
    it "defaults to 2 when stance has no value" do
      stance.importance_value = nil
      expect(stance.importance_value).to eq 2
    end
  end

  describe "#agreeance_value_string" do
    it "returns the string value for the integer" do
      stance.agreeance_value = 1
      expect(stance.agreeance_value_string).to eq "Agree"
    end
  end

  describe "#importance_value_string" do
    it "returns the integer value of the enum" do
      stance.importance_value = 4
      expect(stance.importance_value_string).to eq "Very Important"
    end
  end
end
